CREATE SCHEMA gb_home_work;

-- 1. Создайте таблицу с мобильными телефонами, используя графический интерфейс. 
-- Заполните БД данными. Добавьте скриншот на платформу в качестве ответа на ДЗ

USE gb_home_work;
CREATE TABLE phones (
	id INT PRIMARY KEY AUTO_INCREMENT,
	ProductName VARCHAR(25) NULL,
	Manufacturer VARCHAR(25) NULL,
	ProductCount INT NULL,
	Price INT NULL
	);


INSERT INTO phones (ProductName, Manufacturer, ProductCount, Price) 
VALUES ('iPhone X', 'Apple', '3', '76000'),
    ('iPhone 8', 'Apple', '2', '51000'),
    ('Galaxy S9', 'Samsung', '2', '56000'),
    ('Galaxy S8', 'Samsung', '1', '41000'),
    ('P20 Pro', 'Huawei', '5', '36000');


-- 2. Выведите название, производителя и цену для товаров, количество которых превышает 2 (SQL - файл, скриншот, либо сам код)
    
SELECT ProductName, Manufacturer, Price
FROM phones
WHERE ProductCount > 2;

-- 3. Выведите весь ассортимент товаров марки “Samsung”

SELECT *
FROM phones
WHERE Manufacturer = 'Samsung';


-- 4. Выведите информацию о телефонах, где суммарный чек больше 100 000 и меньше 145 000**

SELECT *
FROM phones
WHERE ProductCount * Price >  100000 AND ProductCount * Price < 145000;


-- 4.*** С помощью регулярных выражений найти (можно использовать операторы “LIKE”, “RLIKE” для 4.3 ):

-- Товары, в которых есть упоминание "Iphone"

SELECT *
FROM phones
WHERE ProductName LIKE 'Iphone%';

-- "Galaxy"

SELECT *
FROM phones
WHERE ProductName LIKE 'Galaxy%';

-- Товары, в которых есть ЦИФРЫ

SELECT *
FROM phones
WHERE ProductName REGEXP '[0-9]';