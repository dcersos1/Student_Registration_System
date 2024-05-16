DROP TABLE G_ENROLLMENTS;

DROP TABLE SCORE_GRADE;

DROP TABLE CLASSES;

DROP TABLE COURSE_CREDIT;

DROP TABLE PREREQUISITES;

DROP TABLE COURSES;

DROP TABLE STUDENTS;

DROP TABLE LOGS;

CREATE TABLE STUDENTS (
    B# CHAR(9) PRIMARY KEY CHECK (B# LIKE 'B%'),
    FIRST_NAME VARCHAR2(15) NOT NULL,
    LAST_NAME VARCHAR2(15) NOT NULL,
    ST_LEVEL VARCHAR2(10) CHECK (ST_LEVEL IN ('freshman', 'sophomore', 'junior', 'senior', 'master', 'PhD')),
    GPA NUMBER(3, 2) CHECK (GPA BETWEEN 0 AND 4.0),
    EMAIL VARCHAR2(20) UNIQUE,
    BDATE DATE
);

CREATE TABLE COURSES (
    DEPT_CODE VARCHAR2(4),
    COURSE# NUMBER(3) CHECK (COURSE# BETWEEN 100 AND 799),
    TITLE VARCHAR2(20) NOT NULL,
    PRIMARY KEY (DEPT_CODE, COURSE#)
);

CREATE TABLE PREREQUISITES (
    DEPT_CODE VARCHAR2(4) NOT NULL,
    COURSE# NUMBER(3) NOT NULL,
    PRE_DEPT_CODE VARCHAR2(4) NOT NULL,
    PRE_COURSE# NUMBER(3) NOT NULL,
    PRIMARY KEY (DEPT_CODE, COURSE#, PRE_DEPT_CODE, PRE_COURSE#),
    FOREIGN KEY (DEPT_CODE, COURSE#) REFERENCES COURSES ON DELETE CASCADE,
    FOREIGN KEY (PRE_DEPT_CODE, PRE_COURSE#) REFERENCES COURSES ON DELETE CASCADE
);

CREATE TABLE COURSE_CREDIT (
    COURSE# NUMBER(3) PRIMARY KEY,
    CHECK (COURSE# BETWEEN 100 AND 799),
    CREDITS NUMBER(1) CHECK (CREDITS IN (3, 4)),
    CHECK ((COURSE# < 500 AND CREDITS = 4) OR (COURSE# >= 500 AND CREDITS = 3))
);

CREATE TABLE CLASSES (
    CLASSID CHAR(5) PRIMARY KEY CHECK (CLASSID LIKE 'c%'),
    DEPT_CODE VARCHAR2(4) NOT NULL,
    COURSE# NUMBER(3) NOT NULL,
    SECT# NUMBER(2),
    YEAR NUMBER(4),
    SEMESTER VARCHAR2(8) CHECK (SEMESTER IN ('Spring', 'Fall', 'Summer 1', 'Summer 2', 'Winter')),
    LIMIT NUMBER(3),
    CLASS_SIZE NUMBER(3),
    ROOM VARCHAR2(10),
    FOREIGN KEY (DEPT_CODE, COURSE#) REFERENCES COURSES ON DELETE CASCADE,
    UNIQUE(DEPT_CODE, COURSE#, SECT#, YEAR, SEMESTER),
    CHECK (CLASS_SIZE <= LIMIT),
    CHECK ((CLASS_SIZE >= 6 AND COURSE# >= 500) OR CLASS_SIZE >= 10)
);

CREATE TABLE SCORE_GRADE (
    SCORE NUMBER(4, 2) PRIMARY KEY,
    LGRADE VARCHAR2(2) CHECK (LGRADE IN ('A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D', 'F', 'I'))
);

CREATE TABLE G_ENROLLMENTS (
    G_B# CHAR(9) REFERENCES STUDENTS,
    CLASSID CHAR(5) REFERENCES CLASSES,
    SCORE NUMBER(4, 2) REFERENCES SCORE_GRADE,
    PRIMARY KEY (G_B#, CLASSID)
);

CREATE TABLE LOGS (
    LOG# NUMBER(4) PRIMARY KEY,
    USER_NAME VARCHAR2(10) NOT NULL,
    OP_TIME DATE NOT NULL,
    TABLE_NAME VARCHAR2(13) NOT NULL,
    OPERATION VARCHAR2(6) NOT NULL,
    TUPLE_KEYVALUE VARCHAR2(20)
);

INSERT INTO STUDENTS VALUES (
    'B00000001',
    'Anne',
    'Broder',
    'master',
    3.7,
    'broder@bu.edu',
    '17-JAN-94'
);

INSERT INTO STUDENTS VALUES (
    'B00000002',
    'Terry',
    'Buttler',
    'master',
    3.0,
    'buttler@bu.edu',
    '28-MAY-93'
);

INSERT INTO STUDENTS VALUES (
    'B00000003',
    'Tracy',
    'Wang',
    'master',
    4.0,
    'wang@bu.edu',
    '06-AUG-97'
);

INSERT INTO STUDENTS VALUES (
    'B00000004',
    'Barbara',
    'Callan',
    'master',
    2.5,
    'callan@bu.edu',
    '18-OCT-95'
);

INSERT INTO STUDENTS VALUES (
    'B00000005',
    'Jack',
    'Smith',
    'master',
    3.2,
    'smith@bu.edu',
    '18-OCT-95'
);

INSERT INTO STUDENTS VALUES (
    'B00000006',
    'Terry',
    'Zillman',
    'PhD',
    4.0,
    'zillman@bu.edu',
    '15-JUN-92'
);

INSERT INTO STUDENTS VALUES (
    'B00000007',
    'Becky',
    'Lee',
    'master',
    4.0,
    'lee@bu.edu',
    '12-NOV-96'
);

INSERT INTO STUDENTS VALUES (
    'B00000008',
    'Tom',
    'Baker',
    'master',
    NULL,
    'baker@bu.edu',
    '23-DEC-97'
);

INSERT INTO STUDENTS VALUES (
    'B00000009',
    'Ben',
    'Liu',
    'master',
    3.8,
    'liu@bu.edu',
    '18-MAR-96'
);

INSERT INTO STUDENTS VALUES (
    'B00000010',
    'Sata',
    'Patel',
    'master',
    3.9,
    'patel@bu.edu',
    '12-OCT-94'
);

INSERT INTO STUDENTS VALUES (
    'B00000011',
    'Art',
    'Chang',
    'PhD',
    4.0,
    'chang@bu.edu',
    '08-JUN-93'
);

INSERT INTO STUDENTS VALUES (
    'B00000012',
    'Tara',
    'Ramesh',
    'senior',
    3.98,
    'ramesh@bu.edu',
    '29-JUL-98'
);

INSERT INTO COURSES VALUES (
    'CS',
    432,
    'database systems'
);

INSERT INTO COURSES VALUES (
    'Math',
    314,
    'discrete math'
);

INSERT INTO COURSES VALUES (
    'CS',
    240,
    'data structure'
);

INSERT INTO COURSES VALUES (
    'CS',
    575,
    'algorithms'
);

INSERT INTO COURSES VALUES (
    'CS',
    532,
    'database systems'
);

INSERT INTO COURSES VALUES (
    'CS',
    550,
    'operating systems'
);

INSERT INTO COURSES VALUES (
    'CS',
    536,
    'machine learning'
);

INSERT INTO PREREQUISITES VALUES (
    'CS',
    '432',
    'Math',
    '314'
);

INSERT INTO PREREQUISITES VALUES (
    'CS',
    '432',
    'CS',
    '240'
);

INSERT INTO PREREQUISITES VALUES (
    'CS',
    '532',
    'CS',
    '432'
);

INSERT INTO PREREQUISITES VALUES (
    'CS',
    '536',
    'CS',
    '532'
);

INSERT INTO PREREQUISITES VALUES (
    'CS',
    '575',
    'CS',
    '240'
);

INSERT INTO COURSE_CREDIT VALUES (
    432,
    4
);

INSERT INTO COURSE_CREDIT VALUES (
    314,
    4
);

INSERT INTO COURSE_CREDIT VALUES (
    240,
    4
);

INSERT INTO COURSE_CREDIT VALUES (
    536,
    3
);

INSERT INTO COURSE_CREDIT VALUES (
    532,
    3
);

INSERT INTO COURSE_CREDIT VALUES (
    550,
    3
);

INSERT INTO COURSE_CREDIT VALUES (
    575,
    3
);

INSERT INTO CLASSES VALUES (
    'c0001',
    'CS',
    432,
    1,
    2021,
    'Spring',
    13,
    12,
    'LH 005'
);

INSERT INTO CLASSES VALUES (
    'c0002',
    'Math',
    314,
    1,
    2020,
    'Fall',
    13,
    12,
    'LH 009'
);

INSERT INTO CLASSES VALUES (
    'c0003',
    'Math',
    314,
    2,
    2020,
    'Fall',
    14,
    11,
    'LH 009'
);

INSERT INTO CLASSES VALUES (
    'c0004',
    'CS',
    432,
    1,
    2020,
    'Spring',
    13,
    13,
    'SW 222'
);

INSERT INTO CLASSES VALUES (
    'c0005',
    'CS',
    536,
    1,
    2021,
    'Spring',
    14,
    13,
    'LH 003'
);

INSERT INTO CLASSES VALUES (
    'c0006',
    'CS',
    532,
    1,
    2021,
    'Spring',
    10,
    9,
    'LH 005'
);

INSERT INTO CLASSES VALUES (
    'c0007',
    'CS',
    550,
    1,
    2021,
    'Spring',
    11,
    11,
    'WH 155'
);

INSERT INTO SCORE_GRADE VALUES (
    92,
    'A'
);

INSERT INTO SCORE_GRADE VALUES (
    79.5,
    'B'
);

INSERT INTO SCORE_GRADE VALUES (
    84,
    'B+'
);

INSERT INTO SCORE_GRADE VALUES (
    72.8,
    'B-'
);

INSERT INTO SCORE_GRADE VALUES (
    76,
    'B'
);

INSERT INTO SCORE_GRADE VALUES (
    65.35,
    'C'
);

INSERT INTO SCORE_GRADE VALUES (
    94,
    'A'
);

INSERT INTO SCORE_GRADE VALUES (
    82,
    'B+'
);

INSERT INTO SCORE_GRADE VALUES (
    88,
    'A-'
);

INSERT INTO SCORE_GRADE VALUES (
    68,
    'C+'
);

INSERT INTO G_ENROLLMENTS VALUES (
    'B00000001',
    'c0001',
    92
);

INSERT INTO G_ENROLLMENTS VALUES (
    'B00000002',
    'c0002',
    76
);

INSERT INTO G_ENROLLMENTS VALUES (
    'B00000003',
    'c0004',
    94
);

INSERT INTO G_ENROLLMENTS VALUES (
    'B00000004',
    'c0004',
    65.35
);

INSERT INTO G_ENROLLMENTS VALUES (
    'B00000004',
    'c0005',
    82
);

INSERT INTO G_ENROLLMENTS VALUES (
    'B00000005',
    'c0006',
    79.5
);

INSERT INTO G_ENROLLMENTS VALUES (
    'B00000006',
    'c0006',
    92
);

INSERT INTO G_ENROLLMENTS VALUES (
    'B00000001',
    'c0002',
    68
);

INSERT INTO G_ENROLLMENTS VALUES (
    'B00000003',
    'c0005',
    NULL
);

INSERT INTO G_ENROLLMENTS VALUES (
    'B00000007',
    'c0007',
    92
);

INSERT INTO G_ENROLLMENTS VALUES (
    'B00000001',
    'c0003',
    76
);

INSERT INTO G_ENROLLMENTS VALUES (
    'B00000001',
    'c0006',
    72.8
);

INSERT INTO G_ENROLLMENTS VALUES (
    'B00000001',
    'c0004',
    94
);

INSERT INTO G_ENROLLMENTS VALUES (
    'B00000001',
    'c0005',
    76
);

INSERT INTO G_ENROLLMENTS VALUES (
    'B00000003',
    'c0001',
    84
);

INSERT INTO G_ENROLLMENTS VALUES (
    'B00000005',
    'c0001',
    76
);

--drops the any instance of log_seq that might exist
DROP SEQUENCE LOG_SEQ;
-- creates a sequence log_sequence where the generated numbers starts at 1000 and increment by 1
CREATE SEQUENCE LOG_SEQ
    START WITH 1000
    INCREMENT BY 1
    NOMAXVALUE;

-- create or replace a trigger named LOGS_BIR which fires before each insert operation on the LOGS table
-- in the scenario wherethe value of the LOG# column for the new row being inserted is NULL then assign the next value from the LOG_SEQ sequence to it
CREATE OR REPLACE TRIGGER LOGS_BIR BEFORE
    INSERT ON LOGS FOR EACH ROW
BEGIN
    IF :NEW.LOG# IS NULL THEN
        :NEW.LOG# := LOG_SEQ.NEXTVAL;
    END IF;
END;
/

-- create a trigger that runs after an insert on g_enrollments

CREATE OR REPLACE TRIGGER TRG_UPDATE_CLASS_SIZE AFTER
    INSERT ON G_ENROLLMENTS FOR EACH ROW

-- declare variables
DECLARE
    V_LIMIT      NUMBER;
    V_CLASS_SIZE NUMBER;

BEGIN
    -- select the limit and class size of new rows in g_enrollments
    SELECT
        LIMIT,
        CLASS_SIZE INTO V_LIMIT,
        V_CLASS_SIZE
    FROM
        CLASSES
    WHERE
        CLASSID = :NEW.CLASSID;

    -- if the current class size is less than the limit then me have to correctly increment the class_size
    IF V_CLASS_SIZE < V_LIMIT THEN
        UPDATE CLASSES
        SET
            CLASS_SIZE = CLASS_SIZE + 1
        WHERE
            CLASSID = :NEW.CLASSID;
    END IF;
END;
/

-- creates a tripper that runs after a delete on g_enrollments
CREATE OR REPLACE TRIGGER TRG_AFTER_DROP_ENROLLMENT AFTER
    DELETE ON G_ENROLLMENTS FOR EACH ROW
BEGIN
 -- update the class size in the classes table after the deletion
    UPDATE CLASSES
    SET
        CLASS_SIZE = CLASS_SIZE - 1
    WHERE
        CLASSID = :OLD.CLASSID;
END;
/

-- creates a trigger that runs after a delete on students
CREATE OR REPLACE TRIGGER TRG_CASCADE_DELETE_ENROLLMENTS AFTER
    DELETE ON STUDENTS FOR EACH ROW
BEGIN
 -- delete related g_enrollments entries that correlate to this delete
    DELETE FROM G_ENROLLMENTS
    WHERE
        G_B# = :OLD.B#;
END;
/

--creates a trigger that runs after an insert on students
CREATE OR REPLACE TRIGGER TRG_LOG_INSERT_STUDENT AFTER
    INSERT ON STUDENTS FOR EACH ROW
BEGIN
-- insert the following details into the LOGS table
    INSERT INTO LOGS (
        USER_NAME,
        OP_TIME,
        TABLE_NAME,
        OPERATION,
        TUPLE_KEYVALUE
    ) VALUES (
        SUBSTR(USER, 1, 10),
        SYSTIMESTAMP,
        'Students',
        'INSERT',
        :NEW.B#
    );
END;
/
--shows errors
show errors;

--creates a trigger that occur after a delete on students
CREATE OR REPLACE TRIGGER TRG_LOG_DELETE_STUDENT AFTER
    DELETE ON STUDENTS FOR EACH ROW
BEGIN
--insert the following details into the LOGS table
    INSERT INTO LOGS (
        USER_NAME,
        OP_TIME,
        TABLE_NAME,
        OPERATION,
        TUPLE_KEYVALUE
    ) VALUES (
        SUBSTR(USER, 1, 10),
        SYSTIMESTAMP,
        'Students',
        'DELETE',
        :OLD.B#
    );
END;
/
--creates a trigger that occurs after an insert on g_enrollments
CREATE OR REPLACE TRIGGER TRG_LOG_INSERT_ENROLLMENT AFTER
    INSERT ON G_ENROLLMENTS FOR EACH ROW
BEGIN
--insert the following details into the LOGS table
    INSERT INTO LOGS (
        USER_NAME,
        OP_TIME,
        TABLE_NAME,
        OPERATION,
        TUPLE_KEYVALUE
    ) VALUES (
        SUBSTR(USER, 1, 10),
        SYSTIMESTAMP,
        'G_Enrollments',
        'INSERT',
        :NEW.G_B#
         || ','
         || :NEW.CLASSID
    );
END;
/
--creates a trigger that occurs after an insert on g_enrollments
CREATE OR REPLACE TRIGGER TRG_LOG_DELETE_ENROLLMENT AFTER
    DELETE ON G_ENROLLMENTS FOR EACH ROW
BEGIN
--insert the following details into the LOGS table
    INSERT INTO LOGS (
        USER_NAME,
        OP_TIME,
        TABLE_NAME,
        OPERATION,
        TUPLE_KEYVALUE
    ) VALUES (
        SUBSTR(USER, 1, 10),
        SYSTIMESTAMP,
        'G_Enrollments',
        'DELETE',
        :OLD.G_B#
         || ','
         || :OLD.CLASSID
    );
END;
/

--BEGIN
--   UniversityDataPkg.Show_Students;
--END;
--/


-- BEGIN
--     UniversityDataPkg.Show_Courses;
-- END;
-- /

-- BEGIN
--     UniversityDataPkg.Show_Prerequisites;
-- END;
-- /

-- BEGIN
--     UniversityDataPkg.Show_Course_Credit;
-- END;
-- /

-- BEGIN
--     UniversityDataPkg.Show_Classes;
-- END;
-- /

-- BEGIN
--     UniversityDataPkg.Show_Score_Grade;
-- END;
-- /

-- BEGIN
--     UniversityDataPkg.Show_G_Enrollments;
-- END;
-- /

-- BEGIN
--     UniversityDataPkg.Show_Logs;
-- END;
-- /

-- BEGIN
--     UniversityDataPkg.Show_Students_By_Class('c0001');
-- END;
-- /

-- BEGIN
--     UniversityDataPkg.Show_Students_By_Class('c0135');
-- END;
-- /

-- BEGIN
--     UniversityDataPkg.Show_All_Prerequisites('CS', 536);
-- END;
-- /

-- BEGIN
--     UniversityDataPkg.Enroll_Student('B99999999', 'c0001');
-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.PUT_LINE('Enrollment Error: ' || SQLERRM);
-- END;
-- /

-- BEGIN
--     UniversityDataPkg.Enroll_Student('B00000012', 'c0001');
-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.PUT_LINE('Enrollment Error: ' || SQLERRM);
-- END;
-- -- /

-- BEGIN
--     UniversityDataPkg.Enroll_Student('B00000001', 'c0002');
-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.PUT_LINE('Enrollment Error: ' || SQLERRM);
-- END;
-- /

-- BEGIN
--     UniversityDataPkg.Enroll_Student('B00000002', 'c0004');
-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.PUT_LINE('Enrollment Error: ' || SQLERRM);
-- END;
-- /

-- BEGIN
--     UniversityDataPkg.Enroll_Student('B00000001', 'c0001');
-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.PUT_LINE('Enrollment Error: ' || SQLERRM);
-- END;
-- /

-- BEGIN
--     UniversityDataPkg.Enroll_Student('B00000001', 'c0007');
-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.PUT_LINE('Enrollment Error: ' || SQLERRM);
-- END;
-- /

-- BEGIN
--     UniversityDataPkg.Enroll_Student('B00000002', 'c0005');
-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.PUT_LINE('Enrollment Error: ' || SQLERRM);
-- END;
-- /


-- Attempt to drop a non-existent student
-- BEGIN
--     UniversityDataPkg.Drop_Student('B00009999', 'c0001');
-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.PUT_LINE(SQLERRM);
-- END;
-- /

-- Testing with a non-existent student ID
-- BEGIN
--     UniversityDataPkg.Delete_Student('B00009999');
-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.PUT_LINE(SQLERRM);
-- END;
-- /

-- BEGIN
--     UniversityDataPkg.Delete_Student('B00000001');
-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.PUT_LINE(SQLERRM);
-- END;
-- /

-- select * from students;
-- select * from g_enrollments;
-- select * from logs;