USE gb_home_work;

-- 1. Используя операторы языка SQL, создайте таблицу “sales”. 
-- Заполните ее данными. Справа располагается рисунок к первому заданию.

CREATE TABLE IF NOT EXISTS sales (
id INT PRIMARY KEY AUTO_INCREMENT,
order_date DATE NOT NULL,
count_product INT NOT NULL
);

INSERT INTO sales (order_date, count_product)
VALUES ('2022-01-01', 156),
	('2022-01-02', 180),
    ('2022-01-03', 21),
    ('2022-01-04', 124),
    ('2022-01-05', 341);
    
    
/* 2.  Для данных таблицы “sales” укажите тип заказа в зависимости от кол-ва : 
меньше 100  -    Маленький заказ
от 100 до 300 - Средний заказ
больше 300  -     Большой заказ
*/

SELECT id,
CASE
    WHEN count_product < 100 THEN "Маленький заказ"
	WHEN count_product BETWEEN 100 AND 300 THEN "Средний заказ"
	ELSE "Большой заказ"
    END AS "Тип заказа"
    FROM sales;
    
SELECT id,
IF (count_product < 100, "Маленький заказ",
	IF (count_product BETWEEN 100 AND 300, "Средний заказ", "Большой заказ"))
AS "Тип заказа"
FROM sales;

/* 3. Создайте таблицу “orders”, заполните ее значениями
Выберите все заказы. В зависимости от поля order_status выведите столбец full_order_status:
OPEN – «Order is in open state» ; CLOSED - «Order is closed»; CANCELLED -  «Order is cancelled»
*/

CREATE TABLE IF NOT EXISTS orders (
	id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id VARCHAR(15) NOT NULL,
    amount DECIMAL(5,2) NOT NULL,
    order_status VARCHAR(15) NOT NULL
); 

INSERT INTO orders (employee_id, amount, order_status)
VALUES ("e03", 15.00, "OPEN"),
		("e01", 25.50, "OPEN"),
        ("e05", 100.07, "CLOSED"),
        ("e02", 22.18, "OPEN"),
        ("e04", 9.50, "CANCELLED");

SELECT *,
CASE
	WHEN order_status = "OPEN" THEN "Order is in open state"
    WHEN order_status = "CLOSED" THEN "Order is closed"
    WHEN order_status = "CANCELLED" THEN "Order is cancelled"
END AS "full_order_status"
FROM orders;

SELECT *,
IF (order_status = "OPEN", "Order is in open state",
	IF (order_status = "CLOSED", "Order is closed", "Order is cancelled"))
AS "full_order_status"
FROM orders;

-- 4.  Чем 0 отличается от NULL?

/*
0 - это числовое значение, которое может применяться в арифмитических операцияхALTER
NULL - представляет отсутствие какого-то значения, Это не то же самое, что 0, и его нельзя использовать в арифметических операциях или сравнениях. 
Вместо этого он часто используется для указания на то, что переменная или выражение не имеют значения, или что значение неизвестно или неинициализировано.
*/
