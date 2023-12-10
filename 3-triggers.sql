--? Завдання:
-- 1. Створити тригер за допомогою оператора CREATE trigger;
-- 2. Для заданої предметної області написати два тригера для різних таблиць
-- бази даних;
-- 3. Видалити тригер за допомогою оператора DROP trigger.
--? КОНТРОЛЬНІ ЗАПИТАННЯ:
-- Що таке тригер?
-- Які є види тригерів?
-- Чи може тригер використовуватись як окрема програма?
-- До яких дій по відношенню до таблиць приводить виконання тригерів?
-- Які оператори використовуються в тригерах?
-- Який зміст мають змінні NEW та OLD в тілі тригера?


CREATE OR REPLACE FUNCTION delete_teacher_classes()
    RETURNS TRIGGER
AS
$$
BEGIN
    DELETE
    FROM assignments
    WHERE discipline_teacher_id IN (SELECT discipline_teacher_id
                                    FROM discipline_teachers
                                    WHERE teacher_id = old.teacher_id);
    DELETE
    FROM discipline_teachers
    WHERE teacher_id = old.teacher_id;
    RETURN old;
END;
$$
    LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS delete_teacher_trigger ON teachers;

CREATE TRIGGER delete_teacher_trigger
    BEFORE DELETE
    ON teachers
    FOR EACH ROW
EXECUTE FUNCTION delete_teacher_classes();

DELETE
FROM teachers
WHERE teacher_id = 1;

CREATE OR REPLACE FUNCTION update_group_graduation_date()
    RETURNS TRIGGER AS
$$
DECLARE
    program_duration INTERVAL := '1 years';
BEGIN
    IF old.added_at IS DISTINCT FROM new.added_at THEN
        new.graduates_at := new.added_at + program_duration;
        RAISE NOTICE 'Updated graduates_at date for group_id % to %', new.group_id, new.graduates_at;
    END IF;

    RETURN new;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_group_graduation_date_trigger ON groups;

CREATE TRIGGER update_group_graduation_date_trigger
    BEFORE UPDATE
    ON groups
    FOR EACH ROW
EXECUTE FUNCTION update_group_graduation_date();

UPDATE GROUPS
SET added_at = '2023-01-01T01:00:00Z'
WHERE name = 'TR-14';
