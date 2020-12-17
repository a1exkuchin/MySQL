--Практическое задание по теме «Операторы, фильтрация, сортировка и ограничение»

--1. Пусть в таблице users поля created_at и updated_at оказались незаполненными.Заполните их текущими датой и временем.

--Добавляем два новых столбца
ALTER TABLE vk.users ADD COLUMN created_at DATETIME;
ALTER TABLE vk.users ADD COLUMN updated_at DATETIME;

--Заполняем стобцы
UPDATE users SET created_at = NOW();
UPDATE users SET updated_at = NOW();

/*2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время 
помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.*/


--Готовим данные в столбцах
ALTER TABLE users MODIFY created_at VARCHAR(20);
UPDATE users SET created_at = '20.10.2017 8:10';
ALTER TABLE users MODIFY updated_at VARCHAR(20);
UPDATE users SET updated_at = '20.10.2017 8:10';

--Выполняем задание
ALTER TABLE users ADD created_at_1 DATETIME;
UPDATE users SET created_at_1 = DATE_FORMAT(STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'), '%Y-%m-%d %H:%i');
ALTER TABLE users DROP created_at, CHANGE created_at_1 created_at DATETIME;

ALTER TABLE users ADD updated_at_1 DATETIME;
UPDATE users SET updated_at_1 = DATE_FORMAT(STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i'), '%Y-%m-%d %H:%i');
ALTER TABLE users DROP updated_at, CHANGE updated_at_1 updated_at DATETIME;

/*3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился 
и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения 
значения value. Однако нулевые запасы должны выводиться в конце, после всех. */

--Создаем и наполняем таблицу storehouses_products
CREATE TABLE storehouses_products (id INT AUTO_INCREMENT, value INT, PRIMARY KEY (id)) COMMENT = 'Остатки на складе';
INSERT INTO storehouses_products (value) VALUES (15), (0), (10), (13), (5), (0);

--Делаем необходимый запрос
SELECT value FROM storehouses_products ORDER BY IF(value > 0, 0, 1), value; 

/*5. Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
Отсортируйте записи в порядке, заданном в списке IN.*/

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);


--Практическое задание теме «Агрегация данных»


/*1. Подсчитайте средний возраст пользователей в таблице users.
Задание выполнялось на примере базы vk, поэтому вместо таблицы users использовалась таблица profiles */

SELECT ROUND(AVG(TIMESTAMPDIFF(year, birthday, now())), 0) FROM profiles;

--Средний возраст пользователей: 22

/*2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.
Задание выполнялось на примере базы vk, поэтому вместо таблицы users использовалась таблица profiles. */

SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday), DAY(birthday))), '%W') AS day_of_week, COUNT(*) AS amount FROM profiles GROUP BY day_of_week ORDER BY amount;

/*3. Подсчитайте произведение чисел в столбце таблицы.
Мы находим произведение чисел столбца id из таблицы users.*/

SELECT ROUND(exp(SUM(ln(id))), 0) FROM users WHERE id < 8;


