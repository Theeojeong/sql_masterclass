CREATE TABLE users (
	username CHAR(10), -- 만약 'nico'가 입력되면 'nico      ' 이렇게 공백으로 10자리를 모두 채우고 저장이 된다
		-- 그래서 char 타입은 username이 항상 10글자라는 걸 확실히 알 때만 사용해야 한다
		-- CHAR의 최대치는 255자
	email VARCHAR(50), -- var는 variable(가변적인), 50자를 채우지 않아도 공백이 추가되지 않는다, 즉 최대 길이를 의미
	gender ENUM('Male', 'Female'), -- ENUM의 역할은 column을 Male 또는 Female만 지정할 수 있게 제한한다
	interests 
	SET('Technology', --SET은 ENUM과 달리 선택지 중에서 원하는 것을 선택할 수 있다
		'Sports',
		'Music',
		'Art',
		'Travel',
		'Food',
		'Fashion',
		'Science'
		),
	bio TEXT, -- TINYTEXT 최대 255자를 지원. TEXT 최대 65,535자를 지원(64KB). MEDIUMTEXT 최대 16,777,215자를 지원(16MB). 
				 -- LONGTEXT 최대 4,294,967,295자를 지원(4GB)
				 -- MEDIUMTEXT이나 LONGTEXT를 사용하면 성능에 영향을 주기 때문에 고민해서 선택하자
	profile_picture TINYBLOB, -- TINYBLOB, BLOB, MEDIUMBLOB, LONGBLOB 의 옵션이 있다
		-- 1. TINYINT
			-- Signed: -> Signed number는 음수가 될 수 있는 버전이다
				-- Range: -128 to 127
			-- Unsigned:
				-- Range: 0 to 255
		
		-- 2. SMALLINT
			-- Signed:
				-- Range: -32,768 to 32,767
			-- Unsigned:
				-- Range: 0 to 65,535
		
		-- 3. MEDIUMINT
			-- Signed:
				-- Range: -8,388,608 to 8,388,607
			-- Unsigned:
				-- Range: 0 to 16,777,215
		
		-- 4. INT (INTEGER)
			-- Signed:
				-- Range: -2,147,483,648 to 2,147,483,647
			-- Unsigned:
				-- Range: 0 to 4,294,967,295
		
		-- 5. BIGINT
			-- Signed:
				-- Range: -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807
			-- Unsigned:
				-- Range: 0 to 18,446,744,073,709,551,615
	age TINYINT UNSIGNED, -- 양수만 작성 가능 
	is_admin BOOLEAN -- BOOLEAN은 TINYINT(1,0)의 별칭일 뿐이다
)
