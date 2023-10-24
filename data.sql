INSERT INTO teachers(first_name, last_name, degree, position, previous_experience_days, joined_department_at)
  VALUES ('John', 'Doe', 'PhD', 'Professor', 100, '2022-01-01'),
('Jane', 'Smith', 'Master', 'Lecturer', 50, '2021-05-01'),
('Michael', 'Johnson', 'PhD', 'Associate Professor', 80, '2020-09-01');

INSERT INTO disciplines(name, description, lecture_hours, practice_hours)
  VALUES ('Mathematics', 'Study of numbers and shapes', 3, 2),
('Physics', 'Study of matter and energy', 4, 1),
('Chemistry', 'Study of substances and their properties', 3, 1);

INSERT INTO GROUPS (name, added_at, graduates_at)
  VALUES ('TR-14', '2022-09-01', '2025-06-30'),
('TR-13', '2023-03-15', '2025-12-31'),
('TR-12', '2023-07-01', '2026-01-31');

INSERT INTO discipline_teachers(discipline_teacher_id, teacher_id, discipline_id, teacher_role)
  VALUES (1, 1, 1, 'Practicum'),
(2, 2, 2, 'Lecturer'),
(3, 3, 1, 'Practicum'),
(4, 3, 3, 'Lecturer');

INSERT INTO assignments(discipline_teacher_id, group_id, starts_at, ends_at)
  VALUES (1, 1, '2022-10-01 11:00', '2022-10-01 12:30'),
(2, 2, '2023-01-15 08:00', '2023-01-15 09:30'),
(3, 1, '2022-11-01 12:00', '2022-11-01 15:00'),
(4, 3, '2023-02-15 09:30', '2023-02-15 10:30');

