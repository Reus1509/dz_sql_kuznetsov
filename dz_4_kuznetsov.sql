#1. Вывести на экран сколько машин каждого цвета для машин марок BMW и LADA
SELECT MARK, color, COUNT(color) AS 'Quantity of cars' FROM AUTO
WHERE MARK = 'LADA'
GROUP BY color, mark 
UNION SELECT MARK, color, COUNT(color) AS 'Quantity of cars' FROM AUTO
WHERE MARK = 'BMW'
GROUP BY color, mark;

#2. Вывести на экран марку авто и количество AUTO не этой марки
SELECT MARK, count(*),  all_auto - count(*)
FROM AUTO 
JOIN (SELECT COUNT(*) AS all_auto FROM AUTO) tab
GROUP BY MARK;

#3. Даны 2 таблицы, созданные следующим образом:
create table test_a (id INT, data varchar(21));
create table test_b (id INT);
insert into test_a(id, data) values
(10, 'A'),
(20, 'A'),
(30, 'F'),
(40, 'D'),
(50, 'C');
insert into test_b(id) values
(10),
(30),
(50);
#Напишите запрос, который вернет строки из таблицы test_a, id которых нет в таблице test_b, НЕ используя ключевого слова NOT.

SELECT * FROM test_a
NATURAL LEFT JOIN test_b
WHERE test_b.id IS NULL;