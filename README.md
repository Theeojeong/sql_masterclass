# SQL Masterclass - 자율 에이전트 시스템

이 프로젝트는 "ok computer" 또는 "manus" 스타일의 자율 에이전트 시스템을 포함합니다.

## 🚀 에이전트 시스템

자동으로 작업을 계획하고 실행하는 AI 에이전트입니다. 파일 읽기/쓰기, SQL 실행, 파일 검색 등 다양한 작업을 수행할 수 있습니다.

### 주요 기능

- **자동 계획 수립**: 목표를 받아 단계별 계획을 자동으로 생성
- **도구 시스템**: 다양한 도구를 사용하여 작업 수행
  - 파일 읽기/쓰기
  - 디렉토리 목록 조회
  - SQL 쿼리 실행
  - 파일 검색
  - 시스템 명령 실행
- **상태 관리**: 작업 진행 상황 추적 및 히스토리 관리
- **에러 처리**: 실패 시 재시도 및 대안 시도

### 사용 방법

#### 1. 대화형 모드

```bash
python run_agent.py --interactive
```

또는

```bash
python -m agent.main --interactive
```

#### 2. 단일 명령 실행

```bash
python run_agent.py "SQLite 폴더의 모든 SQL 파일 목록을 보여줘"
```

```bash
python run_agent.py "강의노트4-3.sql 파일을 읽어줘"
```

```bash
python run_agent.py "movies 테이블의 모든 데이터를 조회해줘" --name "SQLAgent"
```

### 예제

#### 파일 읽기
```python
from agent import Agent

agent = Agent(name="FileReader")
result = agent.run("SQLite/#4 DATA MANIPULATION LANGUAGE/강의노트4-3.sql 파일을 읽어줘")
print(result["context"]["content"])
```

#### SQL 실행
```python
from agent import Agent

agent = Agent(name="SQLAgent")
result = agent.run("movies 테이블에서 director별 총 revenue를 계산해줘", 
                   context={"query": "SELECT director, SUM(revenue) FROM movies GROUP BY director"})
```

#### 파일 검색
```python
from agent import Agent

agent = Agent(name="SearchAgent")
result = agent.run("GROUP BY가 포함된 모든 SQL 파일을 찾아줘",
                   context={"pattern": "GROUP BY"})
```

### 도구 목록

에이전트가 사용할 수 있는 도구들:

1. **read_file**: 파일 읽기
2. **write_file**: 파일 쓰기
3. **list_directory**: 디렉토리 목록 조회
4. **execute_sql**: SQL 쿼리 실행
5. **execute_command**: 시스템 명령 실행
6. **search_files**: 파일 내용 검색

### 프로젝트 구조

```
/workspace
├── agent/
│   ├── __init__.py      # 패키지 초기화
│   ├── agent.py         # 에이전트 핵심 클래스
│   ├── tools.py         # 도구 시스템
│   └── main.py          # 메인 실행 스크립트
├── run_agent.py         # 실행 스크립트
├── SQLite/              # SQL 예제 파일들
└── pyproject.toml       # 프로젝트 설정
```

### 확장하기

새로운 도구를 추가하려면 `agent/tools.py`에 새로운 `Tool` 클래스를 만들고 `ToolRegistry`에 등록하세요:

```python
class MyCustomTool(Tool):
    def __init__(self):
        super().__init__(
            name="my_tool",
            description="내 커스텀 도구 설명"
        )
    
    def execute(self, **kwargs):
        # 도구 로직 구현
        return {"success": True, "result": "..."}

# 등록
registry = ToolRegistry()
registry.register(MyCustomTool())
```

### 라이선스

이 프로젝트는 교육 목적으로 만들어졌습니다.
