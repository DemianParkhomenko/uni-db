DO $$
BEGIN
  RAISE NOTICE 'Task 1: Creating a view for a single table';
END
$$;

DROP VIEW IF EXISTS teacher_details;

CREATE VIEW teacher_details AS
SELECT
  teacher_id,
  first_name,
  last_name,
  degree,
  position,
  previous_experience_days / 365 AS experience_years
FROM
  teachers;

SELECT
  *
FROM
  teacher_details;

DO $$
BEGIN
  RAISE NOTICE 'Task 2: Creating a view for multiple tables';
END
$$;

DROP VIEW IF EXISTS teacher_discipline_details;

CREATE VIEW teacher_discipline_details AS
SELECT
  t.teacher_id,
  t.first_name,
  t.last_name,
  d.name AS discipline_name,
  dt.teacher_role
FROM
  teachers t
  JOIN discipline_teachers dt ON t.teacher_id = dt.teacher_id
  JOIN disciplines d ON dt.discipline_id = d.discipline_id;

SELECT
  *
FROM
  teacher_discipline_details;

DO $$
BEGIN
  RAISE NOTICE 'Task 3: Creating a view for group details and a rule for updating through the view';
END
$$;

DROP VIEW IF EXISTS group_details;

DROP RULE IF EXISTS update_group_details ON GROUPS;

CREATE VIEW group_details AS
SELECT
  group_id,
  name,
  added_at,
  graduates_at
FROM
  GROUPS;

CREATE RULE update_group_details AS ON UPDATE
  TO group_details
    DO INSTEAD
    UPDATE
      GROUPS SET
      graduates_at = NEW.graduates_at WHERE
      group_id = NEW.group_id;

SELECT
  *
FROM
  group_details;

DO $$
DECLARE
  teacher RECORD;
  cur_teacher CURSOR FOR
    SELECT
      *
    FROM
      teachers;
BEGIN
  RAISE NOTICE 'Task 4: Creating a cursor for processing teachers';
  OPEN cur_teacher;
  LOOP
    FETCH cur_teacher INTO teacher;
    EXIT
    WHEN NOT FOUND;
    RAISE NOTICE 'Processing teacher: %', teacher.first_name || ' ' || teacher.last_name;
  END LOOP;
  CLOSE cur_teacher;
END;
$$;

