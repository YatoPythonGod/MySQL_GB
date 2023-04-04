USE task_4_4;


/* 
Создать процедуру, которая решает следующую задачу
Выбрать для одного пользователя 5 пользователей в случайной комбинации, которые удовлетворяют хотя бы одному критерию:
а) из одного города
б) состоят в одной группе
в) друзья друзей
*/


DELIMITER //
CREATE PROCEDURE five_friends
(
	IN id INT
)
BEGIN
SELECT u.*
FROM 
(SELECT u.*
FROM users u
WHERE u.id IN (SELECT p.user_id FROM profiles p WHERE p.hometown = (SELECT p.hometown FROM profiles p WHERE p.user_id = id))
UNION
-- b
SELECT u.*
FROM users u
WHERE u.id IN (SELECT uc.user_id FROM users_communities uc WHERE uc.community_id IN (SELECT uc.community_id FROM users_communities uc WHERE uc.user_id = id))
UNION
-- с
SELECT u.*
FROM users u
WHERE u.id IN (SELECT fr.target_user_id FROM friend_requests fr WHERE fr.initiator_user_id IN (SELECT fr.target_user_id FROM friend_requests fr WHERE fr.initiator_user_id = id AND fr.status = "approved"))) u 
ORDER BY RAND()
LIMIT 5;

END //
DELIMITER ;

CALL five_friends(4);

-- Создать функцию, вычисляющей коэффициент популярности пользователя

DELIMITER //
CREATE FUNCTION get_popularity (id INT)
RETURNS INT
DETERMINISTIC
RETURN (SELECT rt.RANK FROM (
SELECT 
	u.id,
	fr.initiator_user_id, 
    COUNT(fr.initiator_user_id) AS 'Friends',
    DENSE_RANK() OVER(ORDER BY COUNT(fr.initiator_user_id) DESC) AS "RANK"
    FROM users u
    LEFT JOIN friend_requests fr
    ON u.id = fr.initiator_user_id
    GROUP BY u.id
    ORDER BY u.id
) rt
    WHERE rt.id = id)//
    
DELIMITER ;


SELECT(get_popularity(3));


-- Создать процедуру для добавления нового пользователя с профилем

DELIMITER //
CREATE PROCEDURE append_user
(
	firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(120),
    gender CHAR(1),
    birthday DATE,
	hometown VARCHAR(100),
	filename VARCHAR(255)
)
BEGIN
  DECLARE u_id INT;
  DECLARE p_id INT;
  
  START TRANSACTION; 
  INSERT INTO users (firstname, lastname, email)
  VALUES (firstname, lastname, email);
  COMMIT;
  
  SET @u_id = (SELECT u.id FROM users u WHERE u.email = email LIMIT 1);
  SELECT(@u_id);
  
  
  START TRANSACTION; 
  INSERT INTO media (user_id, media_type_id, filename, created_at)
  VALUES(@u_id, 1, filename, NOW());
  COMMIT;
  
  SET @p_id := (SELECT m.id FROM media m WHERE m.user_id = @u_id AND m.media_type_id = 1 LIMIT 1);
  SELECT(@p_id);
  
  START TRANSACTION; 
  INSERT INTO profiles(user_id, gender, birthday, photo_id, hometown)
  VALUES(u_id, gender, birthday, @p_id, hometown);
  COMMIT;
  END//

DELIMITER ;
-- SELECT u.id FROM users u WHERE u.email = "test7@test7.ru" LIMIT 1;
-- SET @u_id = (SELECT u.id FROM users u WHERE u.email = "test7@test7.ru");
-- SELECT(@u_id);
CALL append_user( "Test", "Testovich", "test9@test.ru",  'm', "1990-03-04", "Moscow", "test_photo")
