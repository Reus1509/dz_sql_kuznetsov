CREATE DATABASE dz_3;
USE dz_3;

CREATE TABLE salepeople 
(
    snum INT NOT NULL PRIMARY KEY,
    sname VARCHAR(15) NOT NULL,
    city VARCHAR(20) NOT NULL,
    comm FLOAT
);

CREATE TABLE customers 
(
    cnum INT NOT NULL PRIMARY KEY,
    cname VARCHAR(15) NOT NULL,
    city VARCHAR(20) NOT NULL,
    raiting INT NOT NULL,
    snum INT,
    FOREIGN KEY (snum) REFERENCES salepeople (snum)
);

CREATE TABLE orders 
(
    onum INT NOT NULL PRIMARY KEY,
    amt FLOAT NOT NULL,
    odate DATE NOT NULL,
    cnum INT,
    snum INT,
    FOREIGN KEY (snum) REFERENCES salepeople (snum),
    FOREIGN KEY (cnum) REFERENCES customers (cnum)
);

INSERT INTO salepeople(snum, sname, city, comm) 
VALUES 	(1001, 'Peel', 'London', 0.12),
		(1002, 'Serres', 'San Jose', 0.13),
        (1004, 'Motika', 'London', 0.11),
        (1007, 'Rifkin', 'Barselona', 0.15),
        (1003, 'Axelrod', 'New York', 0.10);
        
INSERT INTO customers(cnum, cname, city, raiting, snum) 
VALUES 	(2001, 'Hoffman', 'London', 100, 1001),
		(2002, 'Giovanni', 'Rome', 200, 1003),
        (2003, 'Liu', 'San Jose', 200, 1002),
        (2004, 'Grass', 'Berlin', 300, 1002),
        (2006, 'Clemens', 'London', 100, 1001),
        (2008, 'Cisneros', 'San Jose', 300, 1007),
        (2007, 'Pireira', 'Rome', 100, 1004);
        
INSERT INTO orders(onum, amt, odate, cnum, snum) 
VALUES 	(3001, 18.69, DATE '1990/10/03', 2008, 1007),
		(3003, 767.19, DATE '1990/10/03', 2001, 1001),
        (3002, 1900.10, DATE '1990/10/03', 2007, 1004),
        (3005, 5160.45, DATE '1990/10/03', 2003, 1002),
        (3006, 1098.16, DATE '1990/10/03', 2008, 1007),
        (3009, 1713.23, DATE '1990/10/04', 2002, 1003),
        (3007, 75.75, DATE '1990/10/04', 2004, 1002),
        (3008, 4723.00, DATE '1990/10/05', 2006, 1001),
        (3010, 1309.95, DATE '1990/10/06', 2004, 1002),
        (3011, 9891.88, DATE '1990/10/06', 2006, 1002);

SELECT * FROM salepeople, customers, orders;

SELECT * FROM customers;

#Напишите запрос, который вывел бы таблицу со столбцами в следующем порядке: city, sname, snum, comm. (к первой или второй таблице, используя SELECT)
SELECT city, sname, snum, comm FROM salepeople;

#. Напишите команду SELECT, которая вывела бы оценку(rating), сопровождаемую именем каждого заказчика в городе San Jose. (“заказчики”);
SELECT raiting, cname FROM customers WHERE city = 'San Jose';

#3. Напишите запрос, который вывел бы значения snum всех продавцов из таблицы заказов без каких бы то ни было повторений. (уникальные значения в “snum“ “Продавцы”)
SELECT DISTINCT snum FROM orders;

#4*. Напишите запрос, который бы выбирал заказчиков, чьи имена начинаются с буквы G. Используется оператор "LIKE": (“заказчики”)
SELECT * FROM customers WHERE cname LIKE ('G%');

#5. Напишите запрос, который может дать вам все заказы со значениями суммы выше чем $1,000. (“Заказы”, “amt” - сумма)
SELECT * FROM orders WHERE amt > 1000;

#6. Напишите запрос который выбрал бы наименьшую сумму заказа.(Из поля “amt” - сумма в таблице “Заказы” выбрать наименьшее значение)
SELECT MIN(amt) AS min_order_sum FROM orders;

#7. Напишите запрос к таблице “Заказчики”, который может показать всех заказчиков, у которых рейтинг больше 100 и они находятся не в Риме.
SELECT * FROM customers WHERE raiting > 100 AND NOT city = 'Rome';

CREATE TABLE workers 
(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(15) NOT NULL,
    surname VARCHAR(20) NOT NULL,
    speciality VARCHAR(20) NOT NULL,
    seniority INT NOT NULL,
    salary INT NOT NULL,
    age INT NOT NULL
);

INSERT INTO workers (name, surname, speciality, seniority, salary, age)
VALUES 	('Вася', 'Васькин', 'начальник', 40, 100000, 60),
		('Петя', 'Петькин', 'начальник', 8, 70000, 30),
        ('Катя', 'Каткина', 'инженер', 2, 70000, 25),
        ('Саша', 'Сашкин', 'инженер', 12, 50000, 35),
        ('Иван', 'Иванов', 'рабочий', 40, 30000, 59),
        ('Петр', 'Петров', 'рабочий', 20, 25000, 40),
        ('Сидор', 'Сидоров', 'рабочий', 10, 20000, 35),
        ('Антон', 'Антонов', 'рабочий', 8, 19000, 28),
        ('Юра', 'Юркин', 'рабочий', 5, 15000, 25),
        ('Максим', 'Воронин', 'рабочий', 2, 11000, 22),
        ('Юра', 'Галкин', 'рабочий', 3, 12000, 24),
        ('Люся', 'Люськина', 'уборщик', 10, 10000, 49);
        
#Отсортируйте поле “зарплата” в порядке убывания и возрастания
SELECT * FROM workers ORDER BY salary DESC;
SELECT * FROM workers ORDER BY salary ASC;

#Отсортируйте по возрастанию поле “Зарплата” и выведите 5 строк с наибольшей заработной платой (возможен подзапрос)
(SELECT * FROM workers ORDER BY salary DESC LIMIT 5)
ORDER BY salary ASC;

#Выполните группировку всех сотрудников по специальности , суммарная зарплата которых превышает 100000
SELECT speciality, SUM(salary) as salary_sum
FROM workers
GROUP BY speciality
HAVING SUM(salary) >= 100000;