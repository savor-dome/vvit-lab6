-- Созздаем таблицы

CREATE TABLE shop (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) UNIQUE,
    balance FLOAT NOT NULL
);

CREATE TABLE product (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) UNIQUE,
    price FLOAT NOT NULL
);

CREATE TABLE warehouse (
    shop_id INTEGER REFERENCES shop (id),
    product_id INTEGER REFERENCES product (id),
    quantity INTEGER NOT NULL,
    PRIMARY KEY (shop_id, product_id)
);

CREATE TABLE worker (
    worker_id INTEGER PRIMARY KEY,
    shop_id INTEGER REFERENCES shop (id),
    name VARCHAR(255),
    salary INTEGER NOT NULL,
    position VARCHAR(255)
);

-- Заполняем данные

INSERT INTO shop (id, name, balance) VALUES (1, 'пятерочка',31);
INSERT INTO shop (id, name, balance) VALUES (2, 'перекресток',133);

INSERT INTO product VALUES (1, 'молоко', 100);
INSERT INTO product VALUES (2, 'хлеб', 25);
INSERT INTO product VALUES (3, 'гречка', 30);

INSERT INTO warehouse VALUES (1, 1, 20);
INSERT INTO warehouse VALUES (1, 2, 10);
INSERT INTO warehouse VALUES (2, 1, 30);

-- В том числе в новую таблицу
INSERT INTO worker VALUES (1, 1, 'Петя', 1000, 'Продавец');
INSERT INTO worker VALUES (2, 1, 'Вася', 1500, 'Менеджер');
INSERT INTO worker VALUES (3, 1, 'Костя', 2000, 'Управляющий');
INSERT INTO worker VALUES (4, 2, 'Маша', 1000, 'Продавец');
INSERT INTO worker VALUES (5, 2, 'Петр', 1200, 'Управляющий');
INSERT INTO worker VALUES (6, 2, 'Адам', 1000, 'Продавец');

-- Запросы
SELECT
    s.name,
    avg(salary) AS avgSalery
FROM
    worker
        JOIN
    shop AS s ON s.id = shop_id
GROUP BY shop_id ORDER BY avgSalery DESC; -- средняя зарплата по магазину с названием магазина, отспортированая от большего к менеьшему

SELECT
    position, max(salary)
FROM worker
GROUP BY position; -- максимальнаяя зарплата по должности

SELECT
    s.name, position, count() as workerCount
FROM
    worker
        JOIN shop AS s on s.id = shop_id
GROUP BY shop_id, position
ORDER BY workerCount DESC; -- количество людей на одной и той же должности + отсортированное по кол-ву людей
