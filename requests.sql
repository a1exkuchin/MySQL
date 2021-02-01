-- Суммы договоров за 2018 год с разбивкой по контрагентам и сортировкой по убыванию итоговых сумм.

SELECT 
  (SELECT name FROM partner WHERE id = contract.partner_id) as partner, 
  SUM(sum) as itog
FROM 
  contract 
WHERE 
  `date` like '2019%' 
GROUP BY 
  partner 
ORDER BY 
  itog DESC;


-- Сводная таблица передачи ПО подразделениям за 2020 год

SELECT 
  (SELECT short_name FROM department WHERE mol_department_id = department.id) AS department, 
  (SELECT `name` FROM soft WHERE license_soft_id=soft.id) AS soft,
   sum(`number`) AS 'Количество лицензий'
FROM transfer 
WHERE `data` like '2020%'
GROUP BY
  department, soft
ORDER BY
  department, soft;

-- Представление выводящее количество купленного за все время ПО в таблицу `soft_itog` с колонками `soft_id`, `soft` и `itog`.

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `alex`@`%` 
    SQL SECURITY DEFINER
VIEW `soft_itog` AS
    SELECT 
        `license`.`soft_id` AS `soft_id`,
        (SELECT 
                `soft`.`name`
            FROM
                `soft`
            WHERE
                (`license`.`soft_id` = `soft`.`id`)) AS `soft`,
        SUM(`license`.`number`) AS `itog`
    FROM
        `license`
    GROUP BY `soft`

-- Представление выводящее количество переданного подразделениям ПО за все время в таблицу `transfer_itog` с колонками `soft_id`, `soft` и `itog`.

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `alex`@`%` 
    SQL SECURITY DEFINER
VIEW `transfer_itog` AS
    SELECT 
        `transfer`.`license_soft_id` AS `soft_id`,
        (SELECT 
                `soft`.`name`
            FROM
                `soft`
            WHERE
                (`transfer`.`license_soft_id` = `soft`.`id`)) AS `soft`,
        SUM(`transfer`.`number`) AS `itog`
    FROM
        `transfer`
    GROUP BY `soft`

