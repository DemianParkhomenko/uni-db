CREATE USER john_snow WITH PASSWORD 'spider-man';
GRANT SELECT, INSERT ON teachers TO john_snow;
SET ROLE john_snow;

SELECT *
FROM teachers;

INSERT INTO teachers(first_name, last_name, degree, position, previous_experience_days, joined_department_at,teacher_id)
VALUES ('Ken', 'Thompson', 'PhD', 'Professor', 100, '2022-01-01', 100);

DELETE
FROM teachers
WHERE first_name = 'Ken';

SET ROLE demian;
REVOKE SELECT, INSERT ON teachers FROM john_snow;
DROP USER john_snow;