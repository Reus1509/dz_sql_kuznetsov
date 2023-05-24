CREATE DATABASE dz_2_kuznetsov;
USE dz_2_kuznetsov;

# 1. Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными
CREATE TABLE sales
(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_date DATE NOT NULL,
    order_count INT NOT NULL,
    order_summ INT NOT NULL
);

INSERT sales (order_date, order_count, order_summ)
VALUES 	("2023-01-02", 3, 100), 
		("2023-01-13", 2, 240), 
        ("2023-01-11", 4, 350), 
        ("2023-02-23", 2, 280), 
        ("2023-02-24", 1, 50), 
        ("2023-03-01", 10, 500);
        
SELECT * FROM sales;

# 2. Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300.
SELECT order_date, order_count, order_summ,
CASE
	WHEN order_summ < 100
		THEN 'Маленький заказ'
	WHEN order_summ > 100 AND order_summ < 300
		THEN 'Средний заказ'
	ELSE 'Большой заказ'
END AS rating
FROM sales;	

# 3. Создайте таблицу “orders”, заполните ее значениями. Покажите “полный” статус заказа, используя оператор CASE

CREATE TABLE orders 
(
	orderid INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	employeeid VARCHAR(3) NOT NULL,
	amount FLOAT(8,2) NOT NULL,
	orderstatus VARCHAR(20) NOT NULL
);

INSERT orders(employeeid, amount, orderstatus) 
VALUES 	("e03", 15.00, 'OPEN'),
		("e01", 25.50, 'OPEN'),
		("e05", 100.70, 'CLOSED'),
		("e02", 22.18, 'OPEN'),
		("e04", 9.50, 'CANCELLED'),
		("e04", 99.99, 'OPEN');

SELECT * FROM orders;

SELECT orderid, orderstatus,
CASE 
	WHEN orderstatus = 'OPEN' THEN 'Order is in open state.'
	WHEN orderstatus = 'CLOSED' THEN 'Order is closed.'
	WHEN orderstatus = 'CANCELLED' THEN 'Order is in open state.'
	ELSE 'NONE'
END AS order_summary
FROM orders;

/* 4. Чем NULL отличается от 0?
Для числового поля разница в том, что 0 может быть результатом арифметической операции,
 в то время как NULL говорит о том, что значение просто не было указано.
Аналогично - для пустой строки и других типов данных.
NULL как свойство поля читается как NULLABLE - т.е. значение для данного столбца необязательно для указания.
"0", пустая строка и т.д. это тоже значение. NULL же обозначает отсутствие значения.
*/