-- 2. Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, 
-- который больше всех общался с нашим пользователем.

-- Выполним поиск для пользователя London Baumbach (id = 60)
SELECT
  users_id,
  COUNT(*)
FROM likes
WHERE
  users_id IN (SELECT to_users_id FROM friend_requests WHERE `status` = 1 AND from_users_id = 60) OR
  users_id IN (SELECT from_users_id FROM friend_requests WHERE `status` = 1 AND to_users_id = 60)
GROUP BY 
  users_id
ORDER BY count(*) DESC
LIMIT 1;

-- 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

SELECT 
  SUM(cnt) AS 'Количество лайков'
FROM  
(SELECT
  users_id,
  COUNT(*) AS cnt,
  (SELECT TIMESTAMPDIFF(YEAR, birthday, NOW()) FROM profiles WHERE users_id = likes.users_id) AS age
FROM likes
GROUP BY users_id
ORDER BY age
LIMIT 10) AS temp;

-- 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT 
IF((SELECT count(*) FROM likes WHERE users_id IN (SELECT users_id FROM profiles WHERE gender = 'm')) >
(SELECT count(*) FROM likes WHERE users_id IN (SELECT users_id FROM profiles WHERE gender = 'f')), 
'Мужчины поставили больше лайков', 'Женщины поставили больше лайков') AS 'Результат сравнения'; 

-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

SELECT
  from_users_id AS id,
  COUNT(*) AS mes_cnt,
  (SELECT COUNT(*) FROM likes WHERE users_id = messages.from_users_id) AS like_cnt
FROM messages
GROUP BY from_users_id
ORDER BY mes_cnt + like_cnt
LIMIT 10;

