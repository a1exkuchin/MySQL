-- ����� ��������� �� 2018 ��� � ��������� �� ������������ � ����������� �� �������� �������� ����.

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


-- ������� ������� �������� �� �������������� �� 2020 ���

SELECT 
  (SELECT short_name FROM department WHERE mol_department_id = department.id) AS department, 
  (SELECT `name` FROM soft WHERE license_soft_id=soft.id) AS soft,
   sum(`number`) AS '���������� ��������'
FROM transfer 
WHERE `data` like '2020%'
GROUP BY
  department, soft
ORDER BY
  department, soft;

