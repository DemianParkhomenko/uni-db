BEGIN;
INSERT INTO teachers (first_name, last_name, degree, position, previous_experience_days, joined_department_at)
VALUES ('John', 'Doe', 'PhD', 'Professor', 365, NOW());
INSERT INTO disciplines (name, description, lecture_hours, practice_hours)
VALUES ('Database Management', 'Introduction to database systems', 30, 20);
COMMIT;

BEGIN;
UPDATE teachers
SET previous_experience_days = 1
WHERE teacher_id = 1;
SAVEPOINT first_update;
UPDATE teachers
SET previous_experience_days = previous_experience_days + 100
WHERE teacher_id = 1;
ROLLBACK TO SAVEPOINT first_update;
COMMIT;

UPDATE teachers
SET previous_experience_days = 33333
WHERE teacher_id = 1;


BEGIN;
LOCK TABLE disciplines IN SHARE MODE;
UPDATE teachers
SET previous_experience_days = previous_experience_days + 100
WHERE teacher_id = 1;
COMMIT;

