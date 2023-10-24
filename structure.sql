CREATE TYPE teacher_position AS ENUM(
    'Professor',
    'Associate Professor',
    'Assistant Professor',
    'Lecturer'
);

CREATE TYPE teacher_degree AS ENUM(
    'PhD',
    'Master',
    'Bachelor'
);

CREATE TABLE teachers(
    teacher_id serial PRIMARY KEY,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    degree teacher_degree,
    position teacher_position,
    previous_experience_days integer NOT NULL,
    joined_department_at timestamptz
);

CREATE TABLE disciplines(
    discipline_id serial PRIMARY KEY,
    name varchar(100) NOT NULL,
    description text,
    lecture_hours integer NOT NULL,
    practice_hours bigint NOT NULL,
    UNIQUE (name)
);

CREATE TABLE GROUPS (
    group_id serial PRIMARY KEY,
    name varchar(50) NOT NULL,
    added_at timestamp with time zone NOT NULL,
    graduates_at timestamp with time zone NOT NULL,
    UNIQUE (name)
);

CREATE TYPE discipline_teacher_role AS ENUM(
    'Lecturer',
    'Practicum'
);

CREATE TABLE discipline_teachers(
    discipline_teacher_id bigserial PRIMARY KEY,
    teacher_id bigint NOT NULL,
    discipline_id bigint NOT NULL,
    teacher_role discipline_teacher_role NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id),
    FOREIGN KEY (discipline_id) REFERENCES disciplines(discipline_id)
);

CREATE TABLE assignments(
    assignment_id serial PRIMARY KEY,
    discipline_teacher_id bigint NOT NULL,
    group_id bigint NOT NULL,
    starts_at timestamptz NOT NULL,
    ends_at timestamptz NOT NULL,
    CONSTRAINT assignments_same_day CHECK (DATE_TRUNC('day', starts_at) = DATE_TRUNC('day', ends_at)),
    CONSTRAINT starts_before_ends CHECK (starts_at < ends_at),
    FOREIGN KEY (discipline_teacher_id) REFERENCES discipline_teachers(discipline_teacher_id),
    FOREIGN KEY (group_id) REFERENCES GROUPS (group_id)
);

