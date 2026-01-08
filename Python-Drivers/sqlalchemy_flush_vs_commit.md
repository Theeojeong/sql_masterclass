# db.flush() vs db.commit() 차이 완벽 이해하기

> **핵심 목표**: `db.flush()`와 `db.commit()`의 차이를 명확히 이해하고, 왜 `commit` 전에 `flush`를 사용하는지 알아봅니다.

## 1. 비유로 이해하기 (The Mental Model) - 온라인 쇼핑몰 주문

### `db.add(item)` (장바구니 담기)

- 당신이 물건을 집어서 장바구니에 넣었습니다.
- 아직 계산대 직원(DB)은 당신이 뭘 샀는지 모릅니다. 단지 당신 손(Python 메모리)에만 있습니다.

### `db.flush()` (계산대 스캔)

- 물건을 계산대 직원에게 건네주어 바코드를 찍었습니다.
- 영수증에 임시로 가격이 찍히고, **주문 번호(ID)가 생성**됩니다.
- 하지만 아직 **결제(카드 긁기)**는 안 했습니다. 마음이 바뀌면 "잠시만요, 이거 취소할게요"라고 말하고 되돌릴 수 있습니다. (Rollback 가능)
- 다른 손님(다른 트랜잭션)은 아직 당신이 이 물건을 샀는지 모릅니다.

### `db.commit()` (결제 완료)

- 카드를 긁고 결제가 완료되었습니다.
- 이제 물건은 완전히 당신 것이 되었고, 재고가 줄어든 사실이 시스템에 영구적으로 기록됩니다.

---

## 2. 코드 분석: 왜 여기서 flush()를 썼을까?

```python
user_message = Message(conversation_id=conversation.id, role="user", content=payload.content)
db.add(user_message)          # 1. Python 객체 생성 (아직 DB는 모름)

# ... (제목 업데이트 로직) ...

db.flush()                    # 2. 🔥 SQL 전송! (ID 생성됨, 트랜잭션 내에 기록됨)

try:
    # 3. ⚠️ 위험한 작업 (외부 AI 호출)
    result = multi_agent_graph.invoke({"query": payload.content})
    # ...
except Exception as exc:
    db.rollback()             # 4. 실패 시 2번에서 flush한 내용 취소
```

이 코드에서 `db.flush()`가 수행하는 두 가지 핵심 역할은 다음과 같습니다.

### 1) 자동 생성된 ID 확보 (Auto-increment ID)

- `user_message` 객체는 `db.add()` 시점에는 `id`가 `None`입니다. 데이터베이스가 ID를 할당해주기 때문입니다.
- `db.flush()`를 호출하면, SQLAlchemy는 `INSERT INTO messages ...` SQL을 데이터베이스로 보냅니다.
- 이때 데이터베이스는 `id`를 생성하여 Python 객체에 채워줍니다. (이후 로직에서 ID가 필요할 때 필수적입니다.)

### 2) 원자성(Atomicity) 보장과 "Fail Fast"

이것이 가장 중요한 이유입니다. 코드는 **"사용자의 질문 저장"**과 **"AI의 답변 생성"**을 **하나의 묶음(트랜잭션)**으로 처리하고 싶어 합니다.

#### 시나리오 A: flush() 없이 진행했다면?

- `add()`만 한 상태에서 AI 호출(`invoke`)이 시작됩니다. AI가 답변을 만드는 데 10초가 걸립니다.
- 만약 `payload.content`가 너무 길어서 DB의 제약조건(예: 4000자 제한)을 위반하는 데이터였다면?
- 10초 뒤에 AI 답변이 다 만들어지고 나서야 `commit()`을 시도할 때 에러가 터집니다. 이미 비싼 AI 비용과 시간을 낭비한 셈이죠.
- **`flush()`를 먼저 하면 DB 제약조건 위반 여부를 AI 호출 전에 미리 확인(Fail Fast) 할 수 있습니다.**

#### 시나리오 B: AI 호출이 실패한다면?

- `flush()`로 DB에 "나 이거 저장할 거야"라고 알렸지만, 아직 `commit()`은 안 했습니다.
- AI 호출 중 에러가 발생하여 `except` 블록으로 갑니다.
- `db.rollback()`이 실행됩니다.
- 데이터베이스는 flush로 받았던 임시 데이터를 깨끗하게 취소합니다. DB에는 사용자의 질문이 남지 않습니다. (질문만 있고 답변은 없는 '고아 데이터' 방지)
