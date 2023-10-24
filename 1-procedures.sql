CREATE OR REPLACE PROCEDURE free_students()
LANGUAGE plpgsql
AS $$
BEGIN
  DELETE FROM assignments;
END;
$$;

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

