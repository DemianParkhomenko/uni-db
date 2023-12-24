SET ROLE demian;

REVOKE SELECT ON teachers FROM new_user1;
REVOKE SELECT ON groups FROM new_user2;

DROP USER IF EXISTS "new_user1";
DROP USER IF EXISTS "new_user2";

CREATE USER "new_user1" WITH PASSWORD 'einstein';
CREATE USER "new_user2" WITH PASSWORD 'spider-man';

GRANT SELECT ON teachers TO new_user1;
SET ROLE new_user1;
SELECT *
FROM teachers;

SET ROLE demian;

GRANT SELECT ON groups TO new_user2;
SET ROLE new_user2;
SELECT *
FROM groups;

SET ROLE demian;

BEGIN;
UPDATE teachers
SET  first_name = 'Linus Torvalds'
WHERE teacher_id = 1;
ROLLBACK;

SELECT *
FROM teachers;


BEGIN;
UPDATE teachers
SET previous_experience_days = 200
WHERE teacher_id = 1;
SAVEPOINT first_update;
UPDATE teachers
SET previous_experience_days = -200
WHERE teacher_id = 1;
ROLLBACK TO SAVEPOINT first_update;
COMMIT;

SELECT *
FROM teachers;
BEGIN;
LOCK TABLE teachers IN ACCESS EXCLUSIVE MODE;
DO
$$
    BEGIN
        PERFORM PG_SLEEP(20);
    END
$$;
COMMIT;

BEGIN;
UPDATE groups
SET name = 'Cool guys'
WHERE group_id = 1;
UPDATE teachers
SET first_name = 'Cool teacher'
WHERE teacher_id = 1;
ROLLBACK;
