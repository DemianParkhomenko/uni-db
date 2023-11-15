DO $$
BEGIN
  RAISE NOTICE 'Завдання 1: Створення представлення за однією таблицею';
END
$$;

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
  RAISE NOTICE 'Завдання 2: Створення представлення за кількома таблицями';
END
$$;

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
  RAISE NOTICE 'Завдання 3: Створення представлення для деталей групи та правила для оновлення через представлення';
END
$$;

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
  RAISE NOTICE 'Завдання 4: Створення курсору для обробки вчителів';
  OPEN cur_teacher;
  LOOP
    FETCH cur_teacher INTO teacher;
    EXIT
    WHEN NOT FOUND;
    RAISE NOTICE 'Обробка вчителя: %', teacher.first_name || ' ' || teacher.last_name;
  END LOOP;
  CLOSE cur_teacher;
END;
$$;

