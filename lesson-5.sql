--������������ ������� �� ���� ����������, ����������, ���������� � �����������

--1. ����� � ������� users ���� created_at � updated_at ��������� ��������������.��������� �� �������� ����� � ��������.

--��������� ��� ����� �������
ALTER TABLE vk.users ADD COLUMN created_at DATETIME;
ALTER TABLE vk.users ADD COLUMN updated_at DATETIME;

--��������� ������
UPDATE users SET created_at = NOW();
UPDATE users SET updated_at = NOW();

/*2. ������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� 
���������� �������� � ������� 20.10.2017 8:10. ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.*/


--������� ������ � ��������
ALTER TABLE users MODIFY created_at VARCHAR(20);
UPDATE users SET created_at = '20.10.2017 8:10';
ALTER TABLE users MODIFY updated_at VARCHAR(20);
UPDATE users SET updated_at = '20.10.2017 8:10';

--��������� �������
ALTER TABLE users ADD created_at_1 DATETIME;
UPDATE users SET created_at_1 = DATE_FORMAT(STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'), '%Y-%m-%d %H:%i');
ALTER TABLE users DROP created_at, CHANGE created_at_1 created_at DATETIME;

ALTER TABLE users ADD updated_at_1 DATETIME;
UPDATE users SET updated_at_1 = DATE_FORMAT(STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i'), '%Y-%m-%d %H:%i');
ALTER TABLE users DROP updated_at, CHANGE updated_at_1 updated_at DATETIME;

/*3. � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 0, ���� ����� ���������� 
� ���� ����, ���� �� ������ ������� ������. ���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� 
�������� value. ������ ������� ������ ������ ���������� � �����, ����� ����. */

--������� � ��������� ������� storehouses_products
CREATE TABLE storehouses_products (id INT AUTO_INCREMENT, value INT, PRIMARY KEY (id)) COMMENT = '������� �� ������';
INSERT INTO storehouses_products (value) VALUES (15), (0), (10), (13), (5), (0);

--������ ����������� ������
SELECT value FROM storehouses_products ORDER BY IF(value > 0, 0, 1), value; 

/*5. �� ������� catalogs ����������� ������ ��� ������ �������. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
������������ ������ � �������, �������� � ������ IN.*/

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);


--������������ ������� ���� ���������� �������


/*1. ����������� ������� ������� ������������� � ������� users.
������� ����������� �� ������� ���� vk, ������� ������ ������� users �������������� ������� profiles */

SELECT ROUND(AVG(TIMESTAMPDIFF(year, birthday, now())), 0) FROM profiles;

--������� ������� �������������: 22

/*2. ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.
������� ����������� �� ������� ���� vk, ������� ������ ������� users �������������� ������� profiles. */

SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday), DAY(birthday))), '%W') AS day_of_week, COUNT(*) AS amount FROM profiles GROUP BY day_of_week ORDER BY amount;

/*3. ����������� ������������ ����� � ������� �������.
�� ������� ������������ ����� ������� id �� ������� users.*/

SELECT ROUND(exp(SUM(ln(id))), 0) FROM users WHERE id < 8;


