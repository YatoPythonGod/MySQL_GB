CREATE DATABASE IF NOT EXISTS task_5;

USE task_5;

CREATE TABLE IF NOT EXISTS car_data(
	id INT PRIMARY KEY AUTO_INCREMENT,
    car_make VARCHAR(45) NOT NULL,
    car_model VARCHAR(45) NOT NULL,
    price DECIMAL(8,2) NOT NULL
	);

SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\car_data.csv' INTO TABLE car_data
  FIELDS TERMINATED BY ','  IGNORE 1 LINES;


-- cоздайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов

CREATE OR REPLACE VIEW low_price_car AS
	SELECT *
    FROM car_data
    WHERE price <= 25000
    ORDER BY price;
    
SELECT *
FROM low_price_car;

-- 2.	Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW) 

ALTER VIEW low_price_car AS
	SELECT *
    FROM car_data
    WHERE price <= 30000
    ORDER BY price DESC;
    
SELECT *
FROM low_price_car;

-- 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”


CREATE OR REPLACE VIEW  kia_audi AS
	SELECT *
    FROM car_data
    WHERE car_make in ("Kia", "Audi");
    
SELECT *
FROM kia_audi;

CREATE TABLE IF NOT EXISTS train_schedule (
	train_id INT,
    station VARCHAR(45),
    station_time TIME
);

INSERT INTO train_schedule
VALUES
	(110, "San Francisco", "10:00:00"),
    (110, "Redwood City", "10:54:00"),
    (110, "Palo Alto", "11:02:00"),
    (110, "San Jose", "12:35:00"),
    (120, "San Francisco", "11:00:00"),
    (120, "Palo Alto", "12:49:00"),
    (120, "San Jose", "13:30:00");
    
SELECT 
	t.*,
    TIMEDIFF(LEAD (station_time, 1, NULL)  OVER (PARTITION BY train_id), station_time)
    FROM train_schedule t;
    


