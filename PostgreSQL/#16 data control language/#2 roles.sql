-- 'wrtn_dev'라는 이름의 역할(Role)을 만들어요.
-- 역할은 권한들을 모아놓은 그룹이라고 생각하면 돼요.
CREATE ROLE wrtn_dev;

-- wrtn_dev 역할에게 PUBLIC 스키마(기본 데이터베이스 공간)에 있는 모든 테이블을 
-- 보고(SELECT), 추가하고(INSERT), 수정할(UPDATE) 수 있는 권한을 줘요.
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA PUBLIC TO wrtn_dev;

-- 'dev_1'이라는 이름의 실제 사용자를 만들어요.
-- 이 사용자는 비밀번호 'wrtn123dev1'로 로그인할 수 있어요.
CREATE USER dev_1 WITH PASSWORD 'wrtn123dev1';

-- dev_1 사용자에게 wrtn_dev 역할을 줘요.
-- 이제 dev_1은 wrtn_dev가 가진 모든 권한을 사용할 수 있어요.
GRANT wrtn_dev TO dev_1;

-- wrtn_dev 역할이 movies 테이블에 대해 가진 모든 권한을 빼앗아요.
-- (이제 movies 테이블을 볼 수도, 수정할 수도 없어요)
REVOKE ALL ON movies FROM wrtn_dev;

-- wrtn_dev 역할에게 movies 테이블의 'title'(제목) 컬럼만 볼 수 있는 권한을 줘요.
-- (다른 정보는 못 보고, 제목만 볼 수 있어요)
GRANT SELECT (title) ON movies TO wrtn_dev;

-- wrtn_dev 역할에게 accounts 테이블의 'balance'(잔액) 컬럼만 수정할 수 있는 권한을 줘요.
-- (다른 정보는 못 바꾸고, 잔액만 바꿀 수 있어요)
GRANT UPDATE (balance) ON accounts TO wrtn_dev;

-- wrtn_dev 역할이 동시에 1개의 연결만 할 수 있도록 제한해요.
-- (한 번에 한 명만 이 역할로 데이터베이스에 접속할 수 있어요)
ALTER ROLE wrtn_dev WITH CONNECTION LIMIT 1;