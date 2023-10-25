CREATE OR REPLACE PROCEDURE free_students()
LANGUAGE plpgsql
AS $$
BEGIN
  DELETE FROM assignments;
END;
$$;

CALL free_students();

CREATE OR REPLACE PROCEDURE graduate_group(group_name varchar(100))
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE
    GROUPS
  SET
    graduates_at = now()
  WHERE
    name = group_name;
END;
$$;

CALL graduate_group('TR-14');

CREATE OR REPLACE PROCEDURE inc_teacher_experience(id integer)
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE
    teachers
  SET
    previous_experience_days = previous_experience_days + 1
  WHERE
    teacher_id = id;
END;
$$;

CALL inc_teacher_experience(1);

CREATE OR REPLACE PROCEDURE count_teachers(OUT count integer)
LANGUAGE plpgsql
AS $$
BEGIN
  SELECT
    COUNT(*) INTO count
  FROM
    teachers;
END;
$$;

DO $$
DECLARE
  teacher_count integer;
BEGIN
  CALL count_teachers(teacher_count);
  RAISE NOTICE 'Total Teachers: %', teacher_count;
END
$$;

CREATE OR REPLACE FUNCTION avg_experience()
  RETURNS float
  LANGUAGE plpgsql
  AS $$
DECLARE
  avg_exp float;
BEGIN
  SELECT
    AVG(previous_experience_days) INTO avg_exp
  FROM
    teachers;
  RETURN avg_exp;
END;
$$;

SELECT
  avg_experience();

CREATE OR REPLACE FUNCTION total_hours_for_discipline(discipline_name varchar)
  RETURNS int
  AS $$
DECLARE
  total_hours int;
BEGIN
  SELECT
    (lecture_hours + practice_hours) INTO total_hours
  FROM
    disciplines
  WHERE
    name = discipline_name;
  RETURN total_hours;
END;
$$
LANGUAGE plpgsql;

SELECT
  *
FROM
  total_hours_for_discipline('Mathematics');

