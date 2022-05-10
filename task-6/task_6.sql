--1. Покажите информацию по потокам. В отчет выведите номер потока, название курса и дату
--начала занятий.

SELECT
streams.number AS stream_number,
courses.name AS course_name,
streams.started_at AS start_date
FROM streams
INNER JOIN courses
ON streams.course_id = courses.id;

--2. Найдите общее количество учеников для каждого курса. В отчёт выведите название курса и
--количество учеников по всем потокам курса.

SELECT
courses.name AS course_name,
sum(streams.students_amount) as students_amount
FROM streams
INNER JOIN courses
ON streams.course_id = courses.id
group by streams.course_id;

--3. Для всех учителей найдите среднюю оценку по всем проведённым потокам. В отчёт выведите
--идентификатор, фамилию и имя учителя, среднюю оценку по всем проведенным потокам.
--Важно чтобы учителя, у которых не было потоков, также попали в выборку.

SELECT
teachers.id,
teachers.surname || ' ' || teachers.name as teacher,
avg(grade)
FROM teachers 
LEFT JOIN grades
ON teachers.id = grades.teacher_id
LEFT JOIN streams
ON grades.stream_id = streams.id
group by grades.teacher_id;


--TODO 5. Дополнительное задание. Найдите разницу между средней успеваемостью преподавателя с наивысшим соответствующим значением и средней успеваемостью преподавателя с наименьшим значением. Средняя успеваемость считается по всем потокам преподавателя.