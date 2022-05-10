--1. Найдите потоки, количество учеников в которых больше или равно 40. В отчет выведите
--номер потока, название курса и количество учеников.

select number as stream_number, (select name from courses where courses.id = streams.course_id) as course_name, students_amount from streams where students_amount >= 40;

--2. Найдите два потока с самыми низкими значениями успеваемости. В отчет выведите номер
--потока, название курса, фамилию и имя преподавателя (одним столбцом), оценку
--успеваемости.

SELECT
(SELECT number FROM streams WHERE streams.id = grades.stream_id) as stream_number,
(SELECT name FROM courses WHERE courses.id = (select course_id FROM streams WHERE streams.id = grades.stream_id)) AS course_name,
(SELECT surname ||' '|| name FROM teachers WHERE teachers.id = grades.teacher_id) AS teacher_name,
grade
FROM grades
order by grade limit 2;

--3. Найдите среднюю успеваемость всех потоков преподавателя Николая Савельева. В отчёт
--выведите идентификатор преподавателя и среднюю оценку по потокам.

SELECT
teacher_id,
avg(grade)
FROM grades
WHERE grades.teacher_id =
(SELECT id FROM teachers WHERE surname = 'Савельев' AND name = 'Николай')
group by teacher_id;

--4. Найдите потоки преподавателя Натальи Петровой, а также потоки, по которым успеваемость
--ниже 4.8. В отчёт выведите идентификатор потока, фамилию и имя преподавателя. В отчёте
--должно быть 3 столбца - номер потока, фамилия преподавателя, имя преподавателя.

SELECT
(SELECT number FROM streams WHERE streams.id = grades.stream_id) as stream_number,
(SELECT surname FROM teachers WHERE teachers.id = grades.teacher_id) as teacher_surname,
(SELECT name FROM teachers WHERE teachers.id = grades.teacher_id) as teacher_name
FROM grades
WHERE grades.teacher_id =
(SELECT id FROM teachers WHERE surname = 'Петрова' AND name = 'Наталья')
UNION
SELECT
(SELECT number FROM streams WHERE streams.id = grades.stream_id) as stream_number,
(SELECT surname FROM teachers WHERE teachers.id = grades.teacher_id) as teacher_surname,
(SELECT name FROM teachers WHERE teachers.id = grades.teacher_id) as teacher_name
FROM grades
WHERE grade < 4.8;

--5. Дополнительное задание. Найдите разницу между средней успеваемостью преподавателя с
--наивысшим соответствующим значением и средней успеваемостью преподавателя с
--наименьшим значением. Средняя успеваемость считается по всем потокам преподавателя.

SELECT
MAX(final_grade) - MIN(final_grade)
FROM
(SELECT teacher_id, AVG(grade) AS final_grade
FROM grades
GROUP BY teacher_id);