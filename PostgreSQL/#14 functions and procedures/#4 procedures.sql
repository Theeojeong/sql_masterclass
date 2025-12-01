CREATE PROCEDURE set_zero_revenue() AS
$$
	UPDATE movies SET revenue = NULL WHERE revenue = 0;
$$
LANGUAGE SQL;

CALL set_zero_revenue();


CREATE PROCEDURE hello_world_p(IN name TEXT, OUT greeting TEXT) AS
$$
	BEGIN
		greeting = 'hello ' || name || '!';
	END;
$$
LANGUAGE plpgsql;

DROP PROCEDURE hello_world_p;

CALL hello_world_p('theo', NULL);


CREATE PROCEDURE hello_world_i(IN name TEXT, IN lang TEXT, OUT greeting TEXT) AS
$$
	DECLARE
		spanish_hello TEXT := 'chao';
		korean_hello TEXT := 'annyeong';
		chinese_hello TEXT := 'nihao';
	BEGIN
		IF lang = 'korean' THEN
			greeting := korean_hello || name;
		ELSIF lang = 'spanish' THEN
			greeting := spanish_hello || ' ' || name;
		elsif lang = 'chinese' THEN
			greeting := chinese_hello || ' ' || name;
		ELSE
			greeting := 'hello' || ' ' || name;
		END IF;
	END;
$$
LANGUAGE plpgsql;

CALL hello_world_i('theo', 'korean', NULL);