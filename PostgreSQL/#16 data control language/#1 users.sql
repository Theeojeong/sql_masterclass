-- 'wrtn_pm'이라는 이름의 새로운 사용자 계정을 만들어요. 
-- 이 사용자는 로그인할 수 있고, 비밀번호는 'wrtn1673pm'이에요.
CREATE ROLE wrtn_pm WITH login PASSWORD 'wrtn1673pm';

-- wrtn_pm 사용자에게 'movies' 테이블을 볼 수 있는 권한을 줘요.
-- (읽기만 가능하고, 수정이나 삭제는 못해요)
GRANT SELECT ON movies TO wrtn_pm;

-- wrtn_pm 사용자에게 'statuses'와 'accounts' 테이블을 보고 새로운 데이터를 추가할 수 있는 권한을 줘요.
GRANT SELECT, INSERT ON statuses, accounts TO wrtn_pm;

-- 방금 준 권한 중에서 'statuses'와 'accounts' 테이블에 데이터를 추가하는 권한을 다시 빼앗아요.
-- (이제 보기만 가능해요)
REVOKE INSERT ON statuses, accounts FROM wrtn_pm;

-- wrtn_pm 사용자에게 PUBLIC 스키마(기본 데이터베이스 공간)에 있는 모든 테이블을 보고 데이터를 추가할 수 있는 권한을 줘요.
GRANT SELECT, INSERT ON ALL TABLES IN SCHEMA PUBLIC TO wrtn_pm;

-- 방금 준 모든 권한을 다시 빼앗아요.
-- (이제 어떤 테이블도 볼 수 없고 데이터도 추가할 수 없어요)
REVOKE SELECT, INSERT ON ALL TABLES IN SCHEMA PUBLIC FROM wrtn_pm;