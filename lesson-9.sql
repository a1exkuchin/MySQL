-- Практическое задание по теме “Транзакции, переменные, представления”

-- 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 
-- из таблицы shop.users в таблицу sample.users. Используйте транзакции.

-- Создаем базу данных sample
CREATE DATABASE sample;
-- переходим в БД sample
use sample;
-- создаем таблицу sample.users (копию структуры shop.users)

CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'Имя покупателя',
  `birthday_at` date DEFAULT NULL COMMENT 'Дата рождения',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Покупатели';

-- перемещаем запись id = 1

START TRANSACTION;
INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
COMMIT;

-- 2. Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее 
-- название каталога name из таблицы catalogs.

-- переходим в БД shop
use shop;
-- создаем представление
CREATE VIEW prod_name(product_name, catalog_name) AS
SELECT products.name, catalogs.name
FROM products
LEFT JOIN catalogs 
ON products.catalog_id = catalogs.id;

-- проверяем вывод представления
SELECT * FROM prod_name;


-- Практическое задание по теме “Администрирование MySQL” (эта тема изучается по вашему желанию)

-- 1. Создайте двух пользователей которые имеют доступ к базе данных shop. Первому пользователю shop_read 
-- должны быть доступны только запросы на чтение данных, второму пользователю shop — любые операции в пределах 
-- базы данных shop.

-- создаем пользователя shop_read с необходимыми правами
CREATE USER 'shop_read'@'localhost' IDENTIFIED WITH sha256_password BY 'Q1w59753@';
GRANT SELECT ON shop.* TO 'shop_read'@'localhost';

-- тестируем пользователя shop_read 
INSERT INTO catalogs (name)
VALUES('New catalog');
-- выдает сообщение что нет прав: INSERT command denied to user 'shop_read'@'localhost' for table 'catalogs'

SELECT * FROM catalogs;
-- запрос проходит успешно

-- создаем пользователя shop для которого доступны любые операции в базе данных shop
CREATE USER 'shop'@'localhost' IDENTIFIED WITH sha256_password BY 'Q1w59753@';
GRANT ALL ON shop.* TO 'shop'@'localhost';
GRANT GRANT OPTION ON shop.* TO 'shop'@'localhost';

-- Проверяем права пользователя shop 
INSERT INTO catalogs(name)
VALUES('New catalog');
-- запрос проходит успешно
DELETE FROM catalogs
WHERE name='New catalog';
-- запрос проходит успешно
SELECT * FROM catalogs;
-- запрос проходит успешно

-- 2. (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие 
-- первичный ключ, имя пользователя и его пароль. Создайте представление username таблицы accounts, предоставляющий 
-- доступ к столбца id и name. Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако, 
-- мог бы извлекать записи из представления username.

-- спользуем базу sample
use sample;

-- создадим таблицу accounts и заполним ее данными
CREATE TABLE accounts (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	password VARCHAR(255)
);

INSERT INTO accounts VALUES
	(NULL, 'alex', 'qwerty'),
	(NULL, 'fox', '159753'),
	(NULL, 'root', 'toor');

-- создадим представление username
CREATE VIEW username(id, name) AS 
	SELECT id, name FROM accounts;

-- проверим созданную таблицу и представление
SELECT * FROM accounts;
SELECT * FROM username;

-- Создаем пользователя 'user_read'@'localhost' с доступом только к представлению username;

CREATE USER 'user_read'@'localhost' IDENTIFIED WITH sha256_password BY 'Q1w59753@';
GRANT SELECT ON sample.username TO 'user_read'@'localhost';

-- логинимся под shop_reader
use sample;
show tables;
-- показывает только username
SELECT * FROM username;
-- данный запрос проходит 

SELECT * FROM catalogs;
-- на данный запрос нет прав: SELECT command denied to user 'user_read'@'localhost' for table 'catalogs'


-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"

-- 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего 
-- времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция 
-- должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DELIMITER //
CREATE PROCEDURE hello()
BEGIN
  CASE 
    WHEN CURTIME() BETWEEN '06:00:00' AND '12:00:00' THEN
      SELECT 'Доброе утро';
    WHEN CURTIME() BETWEEN '12:00:00' AND '18:00:00' THEN
      SELECT 'Добрый день';
    WHEN CURTIME() BETWEEN '18:00:00' AND '23:59:59' THEN
      SELECT 'Добрый вечер';
    ELSE
      SELECT 'Доброй ночи';
  END CASE;
END //
DELIMITER ;

CALL hello();

-- 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение 
-- NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

DELIMITER //
CREATE TRIGGER checking_fill_name_and_description BEFORE INSERT ON products
FOR EACH ROW BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
		SIGNAL SQLSTATE '45000'	
        SET MESSAGE_TEXT = 'Заполните одно из полей name или description. Оба поля имеют значение NULl';
	END IF;
END//
DELIMITER ;

-- смотрим записался ли триггер
SHOW triggers \G;

-- проверяем работу триггера 

INSERT INTO products (name, description, price, catalog_id)
VALUES (NULL, NULL, 1000, 1); 

INSERT INTO products (name, description, price, catalog_id)
VALUES ("Intel core i7", NULL, 30000, 1);