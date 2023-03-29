CREATE DATABASE IF NOT EXISTS task_4;

USE task_4;

CREATE TABLE `shops` (
	`id` INT,
    `shopname` VARCHAR (100),
    PRIMARY KEY (id)
);

CREATE TABLE `cats` (
	`name` VARCHAR (100),
    `id` INT,
    PRIMARY KEY (id),
    shops_id INT,
    CONSTRAINT fk_cats_shops_id FOREIGN KEY (shops_id)
        REFERENCES `shops` (id)
);

INSERT INTO `shops`
VALUES 
		(1, "Четыре лапы"),
        (2, "Мистер Зоо"),
        (3, "МурзиЛЛа"),
        (4, "Кошки и собаки");

INSERT INTO `cats`
VALUES 
		("Murzik",1,1),
        ("Nemo",2,2),
        ("Vicont",3,1),
        ("Zuza",4,3);
        
        
SELECT *
FROM shops;

SELECT *
FROM cats;

-- 1. Вывести всех котиков по магазинам по id (условие соединения shops.id = cats.shops_id)

SELECT s.* , c.`name` as cat
FROM shops s
JOIN cats c
ON s.id = c.shops_id;

-- 2. Вывести магазин, в котором продается кот “Мурзик” (попробуйте выполнить 2 способами)

SELECT s.shopname
FROM shops s
JOIN cats c
ON s.id = c.shops_id AND c.`name` = "Murzik"; 

SELECT s.shopname
FROM shops s, cats c
WHERE s.id = c.shops_id AND c.`name` = "Murzik"; 

SELECT s.shopname
FROM shops s, (SELECT * FROM cats c WHERE c.`name` = "Murzik") AS c
WHERE s.id = c.shops_id ;

-- 3. Вывести магазины, в которых НЕ продаются коты “Мурзик” и “Zuza”

SELECT s.*
FROM shops s
WHERE s.id NOT IN (
    SELECT c.shops_id
    FROM cats c
    WHERE c.name IN ('Murzik', 'Zuza')
);
