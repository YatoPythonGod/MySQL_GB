-- 1. Создайте функцию, которая принимает кол-во сек и форматирует их в кол-во дней, часов, минут и секунд.
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

DROP PROCEDURE IF EXISTS sec_to_day;

DELIMITER $$

CREATE FUNCTION sec_to_day(seconds INT)
RETURNS TEXT
DETERMINISTIC
IF seconds < 60 THEN 
	RETURN CONCAT(seconds, " ", "seconds");
ELSEIF seconds BETWEEN 60 AND 3599 THEN
	RETURN CONCAT(seconds DIV 60, " ", "minutes", seconds % 60, " ", "seconds");
ELSEIF seconds BETWEEN 3600 AND 86399 THEN
	RETURN CONCAT(seconds DIV 3600 , " ", "hours", " ", (seconds % 3600) DIV 60 , " ", "minutes", " ", seconds % 60, " ", "seconds");
ELSEIF seconds > 86399 THEN
	RETURN CONCAT(seconds DIV 86400 , " ", "days", " ", (seconds % 86400) DIV 3600 , " ", "hours", " ", (seconds % 3600) DIV 60 , " ", "minutes", " ", seconds % 60, " ", "seconds");
END IF; $$

DELIMITER ;

SELECT sec_to_day(123456);
