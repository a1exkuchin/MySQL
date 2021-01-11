-- Практическое задание по теме “Оптимизация запросов”
-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и 
-- products в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного 
-- ключа и содержимое поля name.

CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	name_tbl VARCHAR(60) NOT NULL,
	id_key INT(20) NOT NULL,
	name VARCHAR(60) NOT NULL
) ENGINE = ARCHIVE;

-- Триггер на запись в таблицу users

delimiter //
CREATE TRIGGER write_in_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, name_tbl, id_key, name)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END //
delimiter ;

-- Триггер на запись в таблицу catalogs
delimiter //
CREATE TRIGGER write_in_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, name_tbl, id_key, name)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END //
delimiter ;

-- Триггер на запись в таблицу products

delimiter //
CREATE TRIGGER write_in_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, name_tbl, id_key, name)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END //
delimiter ;

-- Проверяем работу триггеров
SHOW TRIGGERS \G

INSERT INTO users (name, birthday_at)
VALUES ('Alex Kox', '1974-05-06');

INSERT INTO catalogs (name)
VALUES ('Processors');

INSERT INTO products (name, description, price, catalog_id)
VALUES ('Itel Core i7', 'Processor', 23000.00, 6);

SELECT * FROM logs;

-- (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

delimiter //
CREATE PROCEDURE users_insert ()
BEGIN
	DECLARE n INT DEFAULT 1000000;
	WHILE n > 0 DO
		INSERT INTO users(name, birthday_at) VALUES (CONCAT('user_', n), NOW());
		SET n = n - 1;
	END WHILE;
END //
delimiter ;

CALL users_insert();

-- Практическое задание по теме “NoSQL”
-- В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
-- Все манипуляции проводились на тестовой СУБД Redis https://try.redis.io/
-- Для хранения количества посещений используем упорядоченное множество ip_

ZINCRBY ip_ 1 '192.168.1.1'
ZINCRBY ip_ 1 '192.168.1.2'
ZINCRBY ip_ 1 '192.168.1.1'
ZINCRBY ip_ 1 '192.168.1.3'
ZINCRBY ip_ 1 '192.168.1.2'

-- Для конкретного ip посмотреть количество посещений можно так:

ZSCORE ip_ '192.168.1.1'


-- При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, 

-- поиск электронного адреса пользователя по его имени.



-- Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.
