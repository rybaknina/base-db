--1. Создайте представление, которое для каждого курса выводит название, номер последнего потока,
--дату начала обучения последнего потока и среднюю успеваемость курса по всем потокам.

create view courses_info AS
SELECT
courses.name AS course_name,
max(streams.number) AS stream_number,
streams.started_at,
avg(grades.grade) as avg_grade
FROM courses
LEFT JOIN streams ON courses.id = streams.course_id
LEFT JOIN grades ON streams.id = grades.stream_id
group by course_name;

--2. Удалите из базы данных всю информацию, которая относится к преподавателю с идентификатором, равным 3. Используйте транзакцию.

BEGIN TRANSACTION;
DELETE FROM grades WHERE teacher_id = 3;
DELETE FROM teachers WHERE id = 3;
COMMIT;

--3. Создайте триггер для таблицы успеваемости,
--который проверяет значение успеваемости на соответствие диапазону чисел от 0 до 5 включительно.

CREATE TRIGGER check_range_grade BEFORE INSERT
ON grades
BEGIN
	SELECT CASE
	WHEN
		NEW.grade NOT BETWEEN 0 AND 5
	THEN
		RAISE(ABORT, 'Wrong range for grade!')
	END;
END;

--4. Дополнительное задание. Создайте триггер для таблицы потоков, который проверяет,
--что дата начала потока больше текущей даты, а номер потока имеет наибольшее значение среди существующих номеров.
--При невыполнении условий необходимо вызвать ошибку с информативным сообщением.

CREATE TRIGGER check_stream_data BEFORE INSERT
ON streams
BEGIN
    SELECT CASE
    WHEN
        date(NEW.started_at) < date('now')
    THEN
        RAISE(ABORT, 'Invalid data: started_at should be more then now for stream!')
    WHEN
        NEW.number <= (select max(streams.number) from streams)
    THEN
        RAISE(ABORT, 'Invalid data: number should be more then max number for stream!')
    END;
END;
