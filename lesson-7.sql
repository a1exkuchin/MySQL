-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в 
-- интернет магазине.

SELECT users.id AS id_user, users.name, orders.id AS id_order FROM users RIGHT JOIN orders ON users.id = orders.user_id;

-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT products.id AS id_prod, products.price, products.name, catalogs.name AS catalog FROM products JOIN catalogs ON products.catalog_id = catalogs.id; 

-- 3. Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, 
-- to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с 
-- русскими названиями городов.

SELECT id AS flight, (SELECT name FROM cities WHERE label = `from`) AS `from`, (SELECT name FROM cities WHERE label = `to`) AS `to` FROM flights ORDER BY flight;
