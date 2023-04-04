-- 2.	Выведите только четные числа от 1 до 10 включительно. (Через функцию / процедуру)
-- Пример: 2,4,6,8,10 (можно сделать через шаг +  2: х = 2, х+=2)


DELIMITER //

CREATE FUNCTION get_even_numbers(num INT)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE result VARCHAR(255) DEFAULT "";
    i: LOOP
		IF i > num THEN
			LEAVE i;
		END IF;
        IF i % 2 = 0 THEN
            SET result = CONCAT(result, i, ", ");
        END IF;
        SET i = i + 1;
    END LOOP;

    RETURN substring(result, 1, char_length(result) - 2);
END//

DELIMITER ;


SELECT(get_even_numbers(10));

SELECT(get_even_numbers(30));



-- процедура

DELIMITER $$
CREATE PROCEDURE print_even_numbers
(
	IN num INT
)
BEGIN
  DECLARE x INT DEFAULT 2;
  DECLARE result VARCHAR(255) DEFAULT "";
  WHILE x <= num DO
	SET result = CONCAT(result, x, ", ");
    SET x = x + 2;
  END WHILE;
  SELECT(substring(result, 1, char_length(result) - 2));
END $$
DELIMITER ;

CALL print_even_numbers(10);
