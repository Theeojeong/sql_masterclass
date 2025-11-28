```sql
-- ============================================================================
-- Functions vs Procedures 비교 정리
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. 핵심 차이
-- ----------------------------------------------------------------------------
-- Function:  값을 계산해서 반환 (계산기 역할)
-- Procedure: 작업을 실행 (실행자 역할)

-- 비교표:
-- ┌─────────────────┬──────────────────────┬──────────────────────┐
-- │ 구분            │ Function             │ Procedure            │
-- ├─────────────────┼──────────────────────┼──────────────────────┤
-- │ 반환값          │ 필수 (RETURN 필요)    │ 선택 (없어도 됨)      │
-- │ 사용 방법       │ SELECT function()    │ CALL procedure()     │
-- │ SELECT 안에서   │ ✅ 가능              │ ❌ 불가능            │
-- │ 트랜잭션 제어    │ ❌ 불가              │ ✅ 가능              │
-- │ 용도            │ 계산, 조회, 변환      │ 데이터 수정, 작업      │
-- └─────────────────┴──────────────────────┴──────────────────────┘


-- ----------------------------------------------------------------------------
-- 2. Function 예시
-- ----------------------------------------------------------------------------

-- 예시 1: 간단한 계산 함수
CREATE FUNCTION calculate_bonus(salary NUMERIC)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN salary * 0.1;  -- 반환 필수!
END;
$$;

-- 사용: SELECT 안에서
SELECT 
    name, 
    salary, 
    calculate_bonus(salary) as bonus
FROM employees;


-- 예시 2: 등급 판정 함수
CREATE FUNCTION get_grade(score INT)
RETURNS VARCHAR(2)
LANGUAGE plpgsql
AS $$
BEGIN
    IF score >= 90 THEN
        RETURN 'A';
    ELSIF score >= 80 THEN
        RETURN 'B';
    ELSIF score >= 70 THEN
        RETURN 'C';
    ELSE
        RETURN 'F';
    END IF;
END;
$$;

-- 사용
SELECT 
    name, 
    score, 
    get_grade(score) as grade
FROM students;


-- 예시 3: 여러 행을 반환하는 함수
CREATE FUNCTION get_high_earners(min_salary NUMERIC)
RETURNS TABLE (
    emp_name VARCHAR,
    emp_salary NUMERIC,
    dept_name VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        e.name, 
        e.salary, 
        d.dept_name
    FROM employees e
    JOIN departments d ON e.dept_id = d.dept_id
    WHERE e.salary >= min_salary
    ORDER BY e.salary DESC;
END;
$$;

-- 사용
SELECT * FROM get_high_earners(5000000);


-- ----------------------------------------------------------------------------
-- 3. Procedure 예시
-- ----------------------------------------------------------------------------

-- 예시 1: 데이터 삽입 프로시저
CREATE PROCEDURE add_employee(
    emp_name VARCHAR,
    emp_salary NUMERIC,
    emp_dept_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- 직원 추가
    INSERT INTO employees (name, salary, dept_id, created_at)
    VALUES (emp_name, emp_salary, emp_dept_id, CURRENT_TIMESTAMP);
    
    -- 로그 기록
    INSERT INTO activity_log (action, timestamp)
    VALUES ('New employee added: ' || emp_name, CURRENT_TIMESTAMP);
    
    COMMIT;
END;
$$;

-- 사용: CALL로 실행
CALL add_employee('최민수', 5000000, 10);


-- 예시 2: 계좌 이체 프로시저 (트랜잭션 제어)
CREATE PROCEDURE transfer_money(
    from_account INT,
    to_account INT,
    amount NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    current_balance NUMERIC;
BEGIN
    -- 출금 계좌 잔액 확인
    SELECT balance INTO current_balance
    FROM accounts
    WHERE account_id = from_account;
    
    -- 잔액 부족 확인
    IF current_balance < amount THEN
        RAISE EXCEPTION '잔액이 부족합니다';
    END IF;
    
    -- 출금
    UPDATE accounts
    SET balance = balance - amount
    WHERE account_id = from_account;
    
    -- 입금
    UPDATE accounts
    SET balance = balance + amount
    WHERE account_id = to_account;
    
    -- 성공 시 커밋
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        -- 에러 시 롤백
        ROLLBACK;
        RAISE NOTICE '이체 실패: %', SQLERRM;
END;
$$;

-- 사용
CALL transfer_money(1, 2, 100000);


-- 예시 3: 급여 인상 프로시저
CREATE PROCEDURE increase_salary(
    dept_id INT,
    increase_rate NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- 급여 인상
    UPDATE employees
    SET salary = salary * (1 + increase_rate)
    WHERE department_id = dept_id;
    
    -- 변경 로그 기록
    INSERT INTO salary_changes (dept_id, rate, changed_at)
    VALUES (dept_id, increase_rate, CURRENT_TIMESTAMP);
    
    COMMIT;
END;
$$;

-- 사용
CALL increase_salary(10, 0.05);  -- 10번 부서 5% 인상


-- ----------------------------------------------------------------------------
-- 4. 언제 뭘 사용하나?
-- ----------------------------------------------------------------------------

-- Function 사용 시기:
-- ✅ 계산 결과가 필요할 때
-- ✅ SELECT 문에서 사용하고 싶을 때
-- ✅ 값 변환이 필요할 때
-- ✅ 조회만 하고 데이터 변경은 없을 때

-- 예시:
-- SELECT name, get_grade(score) FROM students;
-- SELECT calculate_tax(price) FROM products;


-- Procedure 사용 시기:
-- ✅ 데이터를 수정/삽입/삭제할 때
-- ✅ 트랜잭션 제어가 필요할 때
-- ✅ 여러 단계의 복잡한 작업을 할 때
-- ✅ 배치 작업을 할 때

-- 예시:
-- CALL process_monthly_salary();
-- CALL backup_database();
-- CALL cleanup_old_records();


-- ----------------------------------------------------------------------------
-- 5. 삭제 방법
-- ----------------------------------------------------------------------------

-- Function 삭제
DROP FUNCTION IF EXISTS calculate_bonus;
DROP FUNCTION IF EXISTS get_grade;

-- Procedure 삭제
DROP PROCEDURE IF EXISTS add_employee;
DROP PROCEDURE IF EXISTS transfer_money;


-- ============================================================================
-- 요약
-- ============================================================================
-- Function  = 계산기 📊  (값 반환, SELECT에서 사용, 읽기 위주)
-- Procedure = 실행자 🔧  (작업 수행, CALL로 실행, 쓰기 위주)
-- ============================================================================
```