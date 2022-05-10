ALTER TABLE streams RENAME COLUMN start_date TO started_at;
ALTER TABLE streams ADD COLUMN finished_at TEXT;

INSERT INTO teachers (name, surname, email)  VALUES
  ('Николай', 'Савельев', 'saveliev.n@mai.ru'),
  ('Наталья', 'Петрова', 'petrova.n@yandex.ru'),
  ('Елена','Малышева','malisheva.e@google.com');

INSERT INTO courses (name)  VALUES
('Базы данных'),
('Основы Python'),
('Linux. Рабочая станция');

INSERT INTO streams (course_id, number, started_at, students_amount)  VALUES
(3, 165, '18.08.2020', 34 ),
(2, 178, '02.10.2020', 37 ),
(1, 203, '12.11.2020', 35 ),
(1, 210, '03.12.2020', 41 );

INSERT INTO grades (teacher_id, stream_id, grade)  VALUES
(3, 1, 4.7),
(2, 2, 4.9),
(1, 3, 4.8),
(1, 4, 4.9);
    
  
PRAGMA foreign_keys=off;
BEGIN TRANSACTION;
ALTER TABLE grades RENAME TO _grades_old;

CREATE TABLE grades (
  teacher_id INTEGER NOT NULL,
  stream_id REAL NOT NULL,
  grade REAL NOT NULL,
  PRIMARY KEY(teacher_id, stream_id),
  FOREIGN KEY (teacher_id) REFERENCES teachers(id),
  FOREIGN KEY (stream_id) REFERENCES streams(id)
);

INSERT INTO grades (teacher_id, stream_id, grade)
SELECT teacher_id, stream_id, grade
FROM _grades_old;
COMMIT;
PRAGMA foreign_keys=on;

drop table _grades_old;
