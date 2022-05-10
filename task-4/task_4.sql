--1. Преобразовать дату начала потока в таблице потоков к виду год-месяц-день. Используйте команду UPDATE.
UPDATE streams SET started_at = SUBSTR(started_at, 7, 4) || '-' ||
SUBSTR(started_at, 4, 2) || '-' || SUBSTR(started_at, 1, 2);

--2. Получите идентификатор и номер потока, запланированного на самую позднюю дату.
SELECT id, number FROM streams ORDER BY started_at DESC LIMIT 1;

--3. Покажите уникальные значения года по датам начала потоков обучения.
SELECT distinct(SUBSTR(started_at, 1, 4)) FROM streams;

--4. Найдите количество преподавателей в базе данных. Выведите искомое значение в столбец с именем total_teachers.
select count(*) as total_teachers from teachers;

--5. Покажите даты начала двух последних по времени потоков.
SELECT started_at FROM streams ORDER BY started_at DESC LIMIT 2;

--6. Найдите среднюю успеваемости учеников по потокам преподавателя с идентификатором равным 1.
SELECT AVG(grade) FROM grades GROUP BY teacher_id having teacher_id = 1;

--7. Дополнительное задание (выполняется по желанию): найдите идентификаторы преподавателей, у которых средняя успеваемость по всем потокам меньше 4.8.
SELECT teacher_id FROM grades GROUP BY teacher_id having avg(grade) < 4.8;