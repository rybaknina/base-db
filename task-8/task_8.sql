--1. Найдите общее количество учеников для каждого курса.
--В отчёт выведите название курса и количество учеников по всем потокам курса. Решите задание с применением оконных функций.

SELECT distinct
courses.name AS course_name,
sum(streams.students_amount) over(w_courses) as students_amount
FROM streams
INNER JOIN courses
ON streams.course_id = courses.id
window w_courses as (partition by streams.course_id);

--2. Найдите среднюю оценку по всем потокам для всех учителей. В отчёт выведите идентификатор, фамилию и имя учителя,
--среднюю оценку по всем проведённым потокам. Учителя, у которых не было потоков, также должны попасть в выборку.
--Решите задание с применением оконных функций.

SELECT distinct
teachers.id,
teachers.surname || ' ' || teachers.name as teacher,
avg(grades.grade) over(w_grades) as avg_grade
FROM teachers
LEFT JOIN grades
ON teachers.id = grades.teacher_id
LEFT JOIN streams
ON grades.stream_id = streams.id
window w_grades as (partition by grades.teacher_id);

--3. Какие индексы надо создать для максимально быстрого выполнения представленного запроса?
--SELECT
--  surname,
--  name,
--  number,
--  performance
--FROM academic_performance
--  JOIN teachers
--    ON academic_performance.teacher_id = teachers.id
--  JOIN streams
--    ON academic_performance.stream_id = streams.id
--WHERE number >= 200;

CREATE INDEX teachers_surname_name_idx ON teachers(surname, name);
CREATE INDEX streams_number_idx ON streams(number);

--4. Установите SQLiteStudio, подключите базу данных учителей, выполните в графическом клиенте любой запрос.
see screen screen_sqllite_studio.png

--TODO 5. Дополнительное задание.
--Для каждого преподавателя выведите имя, фамилию, минимальное значение успеваемости по всем потокам преподавателя,
--название курса, который соответствует потоку с минимальным значением успеваемости,
--максимальное значение успеваемости по всем потокам преподавателя, название курса,
--соответствующий потоку с максимальным значением успеваемости, дату начала следующего потока.
--Выполните задачу с использованием оконных функций.