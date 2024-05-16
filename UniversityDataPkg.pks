CREATE OR REPLACE PACKAGE UNIVERSITYDATAPKG IS
 -- Procedures to display data from each table
    PROCEDURE SHOW_STUDENTS;

    PROCEDURE SHOW_COURSES;

    PROCEDURE SHOW_PREREQUISITES;

    PROCEDURE SHOW_COURSE_CREDIT;

    PROCEDURE SHOW_CLASSES;

    PROCEDURE SHOW_SCORE_GRADE;

    PROCEDURE SHOW_G_ENROLLMENTS;

    PROCEDURE SHOW_LOGS;
 -- ref cursor implementation of display data for java
    TYPE REF_CURSOR IS
        REF CURSOR;

    FUNCTION GET_STUDENTS RETURN REF_CURSOR;

    FUNCTION GET_COURSES RETURN REF_CURSOR;

    FUNCTION GET_PREREQUISITES RETURN REF_CURSOR;

    FUNCTION GET_COURSE_CREDIT RETURN REF_CURSOR;

    FUNCTION GET_CLASSES RETURN REF_CURSOR;

    FUNCTION GET_SCORE_GRADE RETURN REF_CURSOR;

    FUNCTION GET_G_ENROLLMENTS RETURN REF_CURSOR;

    FUNCTION GET_LOGS RETURN REF_CURSOR;
 -- Procedure to display students by classid
    PROCEDURE SHOW_STUDENTS_BY_CLASS(
        P_CLASSID IN CHAR
    );
 -- Procedure to display all prereq
    PROCEDURE SHOW_ALL_PREREQUISITES(
        P_DEPT_CODE IN VARCHAR2,
        P_COURSE# IN NUMBER
    );
 -- Procedure for enrolling a graduate student into a class
    PROCEDURE ENROLL_STUDENT(
        P_B# IN CHAR,
        P_CLASSID IN CHAR
    );
 -- procedure for dropping a student from a class
    PROCEDURE DROP_STUDENT(
        P_B# IN CHAR,
        P_CLASSID IN CHAR
    );
 -- procedure to delete student and related enrolled courses
    PROCEDURE DELETE_STUDENT(
        P_B# IN CHAR
    );

    PROCEDURE DELETE_COURSE(
        P_DEPT_CODE IN VARCHAR2,
        P_COURSE# IN NUMBER
    );
 -- PROCEDURE TEST_PREREQUISITES(
 -- P_DEPT_CODE IN VARCHAR2,
 -- P_COURSE_NUM IN NUMBER
 -- );
    PROCEDURE DELETE_CLASS(
        P_CLASSID IN VARCHAR2
    );
END UNIVERSITYDATAPKG;
/

CREATE OR REPLACE PACKAGE BODY UNIVERSITYDATAPKG IS
 -- Implementation to show all students
    PROCEDURE SHOW_STUDENTS IS
        CURSOR C_STUDENTS IS
        SELECT
            *
        FROM
            STUDENTS;
    BEGIN
        FOR REC IN C_STUDENTS LOOP
            DBMS_OUTPUT.PUT_LINE('B#: '
                                 || REC.B#
                                 || ', First Name: '
                                 || REC.FIRST_NAME
                                 || ', Last Name: '
                                 || REC.LAST_NAME
                                 || ', Level: '
                                 || REC.ST_LEVEL
                                 || ', GPA: '
                                 || REC.GPA
                                 || ', Email: '
                                 || REC.EMAIL
                                 || ', Birthdate: '
                                 || TO_CHAR(REC.BDATE, 'DD-MON-YYYY'));
        END LOOP;
    END SHOW_STUDENTS;
 -- Implementation to show all courses
    PROCEDURE SHOW_COURSES IS
        CURSOR C_COURSES IS
        SELECT
            *
        FROM
            COURSES;
    BEGIN
        FOR REC IN C_COURSES LOOP
            DBMS_OUTPUT.PUT_LINE('Dept Code: '
                                 || REC.DEPT_CODE
                                 || ', Course#: '
                                 || REC.COURSE#
                                 || ', Title: '
                                 || REC.TITLE);
        END LOOP;
    END SHOW_COURSES;
 -- Implementation to show all prerequisites
    PROCEDURE SHOW_PREREQUISITES IS
        CURSOR C_PREREQUISITES IS
        SELECT
            *
        FROM
            PREREQUISITES;
    BEGIN
        FOR REC IN C_PREREQUISITES LOOP
            DBMS_OUTPUT.PUT_LINE('Dept Code: '
                                 || REC.DEPT_CODE
                                 || ', Course#: '
                                 || REC.COURSE#
                                 || ', Pre Dept Code: '
                                 || REC.PRE_DEPT_CODE
                                 || ', Pre Course#: '
                                 || REC.PRE_COURSE#);
        END LOOP;
    END SHOW_PREREQUISITES;
 -- Implementation to show course credit information
    PROCEDURE SHOW_COURSE_CREDIT IS
        CURSOR C_COURSE_CREDIT IS
        SELECT
            *
        FROM
            COURSE_CREDIT;
    BEGIN
        FOR REC IN C_COURSE_CREDIT LOOP
            DBMS_OUTPUT.PUT_LINE('Course#: '
                                 || REC.COURSE#
                                 || ', Credits: '
                                 || REC.CREDITS);
        END LOOP;
    END SHOW_COURSE_CREDIT;
 -- Implementation to show all classes
    PROCEDURE SHOW_CLASSES IS
        CURSOR C_CLASSES IS
        SELECT
            *
        FROM
            CLASSES;
    BEGIN
        FOR REC IN C_CLASSES LOOP
            DBMS_OUTPUT.PUT_LINE('Class ID: '
                                 || REC.CLASSID
                                 || ', Dept Code: '
                                 || REC.DEPT_CODE
                                 || ', Course#: '
                                 || REC.COURSE#
                                 || ', Sect#: '
                                 || REC.SECT#
                                 || ', Year: '
                                 || REC.YEAR
                                 || ', Semester: '
                                 || REC.SEMESTER
                                 || ', Limit: '
                                 || REC.LIMIT
                                 || ', Class Size: '
                                 || REC.CLASS_SIZE
                                 || ', Room: '
                                 || REC.ROOM);
        END LOOP;
    END SHOW_CLASSES;
 -- Implementation to show all score grades
    PROCEDURE SHOW_SCORE_GRADE IS
        CURSOR C_SCORE_GRADE IS
        SELECT
            *
        FROM
            SCORE_GRADE;
    BEGIN
        FOR REC IN C_SCORE_GRADE LOOP
            DBMS_OUTPUT.PUT_LINE('Score: '
                                 || REC.SCORE
                                 || ', Letter Grade: '
                                 || REC.LGRADE);
        END LOOP;
    END SHOW_SCORE_GRADE;
 -- Implementation to show all g_enrollments
    PROCEDURE SHOW_G_ENROLLMENTS IS
        CURSOR C_G_ENROLLMENTS IS
        SELECT
            *
        FROM
            G_ENROLLMENTS;
    BEGIN
        FOR REC IN C_G_ENROLLMENTS LOOP
            DBMS_OUTPUT.PUT_LINE('B#: '
                                 || REC.G_B#
                                 || ', Class ID: '
                                 || REC.CLASSID
                                 || ', Score: '
                                 || REC.SCORE);
        END LOOP;
    END SHOW_G_ENROLLMENTS;
 -- Implementation to show all logs
    PROCEDURE SHOW_LOGS IS
        CURSOR C_LOGS IS
        SELECT
            *
        FROM
            LOGS;
    BEGIN
        FOR REC IN C_LOGS LOOP
            DBMS_OUTPUT.PUT_LINE('Log#: '
                                 || REC.LOG#
                                 || ', User Name: '
                                 || REC.USER_NAME
                                 || ', Operation Time: '
                                 || TO_CHAR(REC.OP_TIME, 'DD-MON-YYYY HH24:MI:SS')
                                    || ', Table Name: '
                                    || REC.TABLE_NAME
                                    || ', Operation: '
                                    || REC.OPERATION
                                    || ', Tuple Key Value: '
                                    || REC.TUPLE_KEYVALUE);
        END LOOP;
    END SHOW_LOGS;
 -- function return ref_cursor to students
    FUNCTION GET_STUDENTS RETURN REF_CURSOR IS
        RC REF_CURSOR;
    BEGIN
        OPEN RC FOR
            SELECT
                *
            FROM
                STUDENTS;
        RETURN RC;
    END GET_STUDENTS;
 -- function return ref_cursor to courses
    FUNCTION GET_COURSES RETURN REF_CURSOR IS
        RC REF_CURSOR;
    BEGIN
        OPEN RC FOR
            SELECT
                *
            FROM
                COURSES;
        RETURN RC;
    END GET_COURSES;
 -- function return ref_cursor to prerequisites
    FUNCTION GET_PREREQUISITES RETURN REF_CURSOR IS
        RC REF_CURSOR;
    BEGIN
        OPEN RC FOR
            SELECT
                *
            FROM
                PREREQUISITES;
        RETURN RC;
    END GET_PREREQUISITES;
 -- function return ref_cursor to course_credit
    FUNCTION GET_COURSE_CREDIT RETURN REF_CURSOR IS
        RC REF_CURSOR;
    BEGIN
        OPEN RC FOR
            SELECT
                *
            FROM
                COURSE_CREDIT;
        RETURN RC;
    END GET_COURSE_CREDIT;
 -- function return ref_cursor to classes
    FUNCTION GET_CLASSES RETURN REF_CURSOR IS
        RC REF_CURSOR;
    BEGIN
        OPEN RC FOR
            SELECT
                *
            FROM
                CLASSES;
        RETURN RC;
    END GET_CLASSES;
 -- function return ref_cursor to score_grade
    FUNCTION GET_SCORE_GRADE RETURN REF_CURSOR IS
        RC REF_CURSOR;
    BEGIN
        OPEN RC FOR
            SELECT
                *
            FROM
                SCORE_GRADE;
        RETURN RC;
    END GET_SCORE_GRADE;
 -- function return ref_cursor to enrollments
    FUNCTION GET_G_ENROLLMENTS RETURN REF_CURSOR IS
        RC REF_CURSOR;
    BEGIN
        OPEN RC FOR
            SELECT
                *
            FROM
                G_ENROLLMENTS;
        RETURN RC;
    END GET_G_ENROLLMENTS;
 -- function return ref_cursor to logs
    FUNCTION GET_LOGS RETURN REF_CURSOR IS
        RC REF_CURSOR;
    BEGIN
        OPEN RC FOR
            SELECT
                *
            FROM
                LOGS;
        RETURN RC;
    END GET_LOGS;
 -- Procedure to show students by class
    PROCEDURE SHOW_STUDENTS_BY_CLASS(
        P_CLASSID IN CHAR
    ) IS
        CURSOR C_STUDENTS IS
        SELECT
            S.B#,
            S.FIRST_NAME,
            S.LAST_NAME
        FROM
            STUDENTS      S
            JOIN G_ENROLLMENTS G
            ON S.B# = G.G_B#
        WHERE
            G.CLASSID = P_CLASSID;
        V_CLASS_CHECK NUMBER;
    BEGIN
        SELECT
            COUNT(*) INTO V_CLASS_CHECK
        FROM
            CLASSES
        WHERE
            CLASSID = P_CLASSID;
        IF V_CLASS_CHECK = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'Class is invalid.');
        ELSE
            FOR REC IN C_STUDENTS LOOP
                DBMS_OUTPUT.PUT_LINE('B#: '
                                     || REC.B#
                                     || ', First Name: '
                                     || REC.FIRST_NAME
                                     || ', Last Name: '
                                     || REC.LAST_NAME);
            END LOOP;
        END IF;
    END SHOW_STUDENTS_BY_CLASS;

    PROCEDURE SHOW_ALL_PREREQUISITES(
        P_DEPT_CODE IN VARCHAR2,
        P_COURSE# IN NUMBER
    ) IS
 -- Declaring a cursor that uses a recursive CTE to fetch prerequisites
        CURSOR PREREQUISITES_CURSOR(
            DEPT VARCHAR2,
            COURSE_NUM NUMBER
        ) IS WITH RECURSIVE_PREREQUISITES (
            PRE_DEPT_CODE,
            PRE_COURSE#
        ) AS (
            SELECT
                PRE_DEPT_CODE,
                PRE_COURSE#
            FROM
                PREREQUISITES
            WHERE
                DEPT_CODE = DEPT
                AND COURSE# = COURSE_NUM
            UNION
            ALL
            SELECT
                P.PRE_DEPT_CODE,
                P.PRE_COURSE#
            FROM
                PREREQUISITES           P
                JOIN RECURSIVE_PREREQUISITES RP
                ON RP.PRE_DEPT_CODE = P.DEPT_CODE
                AND RP.PRE_COURSE# = P.COURSE#
        )
        SELECT
            DISTINCT PRE_DEPT_CODE
                     || PRE_COURSE# AS COURSE_CODE
        FROM
            RECURSIVE_PREREQUISITES;
        V_COURSE_EXIST NUMBER;
        V_PREREQ_FOUND BOOLEAN := FALSE; -- Flag to check if any prerequisites are found
    BEGIN
 -- Check if the course exists
        SELECT
            COUNT(*) INTO V_COURSE_EXIST
        FROM
            COURSES
        WHERE
            DEPT_CODE = P_DEPT_CODE
            AND COURSE# = P_COURSE#;
        IF V_COURSE_EXIST = 0 THEN
            DBMS_OUTPUT.PUT_LINE('The course '
                                 || P_DEPT_CODE
                                 || TO_CHAR(P_COURSE#, 'FM000')
                                    || ' does not exist.');
        ELSE
 -- Output all prerequisites
            DBMS_OUTPUT.PUT_LINE('Prerequisites for '
                                 || P_DEPT_CODE
                                 || TO_CHAR(P_COURSE#, 'FM000')
                                    || ':');
            FOR REC IN PREREQUISITES_CURSOR(P_DEPT_CODE, P_COURSE#) LOOP
                DBMS_OUTPUT.PUT_LINE('Course: '
                                     || REC.COURSE_CODE);
                V_PREREQ_FOUND := TRUE;
            END LOOP;

            IF NOT V_PREREQ_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('No prerequisites found for '
                                     || P_DEPT_CODE
                                     || TO_CHAR(P_COURSE#, 'FM000')
                                        || '.');
            END IF;
        END IF;
    END SHOW_ALL_PREREQUISITES;
 -- Procedure to enroll a graduate student into a class
    PROCEDURE ENROLL_STUDENT(
        P_B# IN CHAR,
        P_CLASSID IN CHAR
    ) IS
        V_ST_LEVEL          VARCHAR2(10);
        V_YEAR              NUMBER;
        V_SEMESTER          VARCHAR2(8);
        V_LIMIT             NUMBER;
        V_CLASS_CHECK       NUMBER;
        V_CLASS_SIZE        NUMBER;
        V_TOTAL_ENROLLMENTS NUMBER;
        V_COUNT_ENROLLMENT  NUMBER;
        V_DEPT_CODE         VARCHAR2(4);
        V_COUNT             NUMBER;
        V_COURSE#           NUMBER(3);
        V_PREREQ_NOT_MET    NUMBER := 0;
        CURSOR PREREQUISITES_CURSOR(
            P_DEPT_CODE VARCHAR2,
            P_COURSE_NUM NUMBER
        ) IS WITH RECURSIVE_PREREQUISITES (
            PRE_DEPT_CODE,
            PRE_COURSE#
        ) AS (
            SELECT
                PRE_DEPT_CODE,
                PRE_COURSE#
            FROM
                PREREQUISITES
            WHERE
                DEPT_CODE = P_DEPT_CODE
                AND COURSE# = P_COURSE_NUM
            UNION
            ALL
            SELECT
                P.PRE_DEPT_CODE,
                P.PRE_COURSE#
            FROM
                PREREQUISITES           P
                INNER JOIN RECURSIVE_PREREQUISITES RP
                ON P.DEPT_CODE = RP.PRE_DEPT_CODE
                AND P.COURSE# = RP.PRE_COURSE#
        )
        SELECT
            DISTINCT PRE_DEPT_CODE,
            PRE_COURSE#
        FROM
            RECURSIVE_PREREQUISITES;
        V_PREREQ_RECORD     PREREQUISITES_CURSOR%ROWTYPE;
    BEGIN
 -- Validate the B# exists and is a graduate student
        BEGIN
            SELECT
                ST_LEVEL INTO V_ST_LEVEL
            FROM
                STUDENTS
            WHERE
                B# = P_B#;
            IF V_ST_LEVEL NOT IN ('master', 'PhD') THEN
                RAISE_APPLICATION_ERROR(-20002, 'This is not a graduate student.');
            END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20001, 'The B# is invalid.');
        END;
 -- Validate the classid
        SELECT
            COUNT(*) INTO V_CLASS_CHECK
        FROM
            CLASSES
        WHERE
            CLASSID = P_CLASSID;
        IF V_CLASS_CHECK = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'Class is invalid.');
        END IF;
 -- Cannot enroll into previous semester
        SELECT
            YEAR,
            SEMESTER,
            LIMIT,
            CLASS_SIZE INTO V_YEAR,
            V_SEMESTER,
            V_LIMIT,
            V_CLASS_SIZE
        FROM
            CLASSES
        WHERE
            CLASSID = P_CLASSID;
        IF V_YEAR != 2021 OR V_SEMESTER != 'Spring' THEN
            RAISE_APPLICATION_ERROR(-20011, 'Cannot enroll into a class from a previous semester.');
        END IF;
        
 -- checking the class size
        SELECT
            YEAR,
            SEMESTER,
            LIMIT,
            CLASS_SIZE INTO V_YEAR,
            V_SEMESTER,
            V_LIMIT,
            V_CLASS_SIZE
        FROM
            CLASSES
        WHERE
            CLASSID = P_CLASSID;
        IF V_CLASS_SIZE >= V_LIMIT THEN
            RAISE_APPLICATION_ERROR(-20005, 'The class is already full.');
        END IF;

 -- Check if the student is already enrolled in the class
        SELECT
            COUNT(*) INTO V_COUNT_ENROLLMENT
        FROM
            G_ENROLLMENTS
        WHERE
            G_B# = P_B#
            AND CLASSID = P_CLASSID;
        IF V_COUNT_ENROLLMENT > 0 THEN
            RAISE_APPLICATION_ERROR(-20006, 'The student is already in the class.');
        END IF;

 -- check student enrolled more than five classes
        SELECT
            COUNT(*) INTO V_COUNT
        FROM
            G_ENROLLMENTS GE
            JOIN CLASSES C
            ON GE.CLASSID = C.CLASSID
        WHERE
            GE.G_B# = P_B#
            AND C.YEAR = 2021
            AND C.SEMESTER = 'Spring';
 -- If the student is already enrolled in 5 or more classes, prevent the insertion
        IF V_COUNT >= 5 THEN
            RAISE_APPLICATION_ERROR(-20020, 'Students cannot be enrolled in more than five classes in the same semester.');
        END IF;

 -- Check prerequisites recursively
        SELECT
            DEPT_CODE,
            COURSE# INTO V_DEPT_CODE,
            V_COURSE#
        FROM
            CLASSES
        WHERE
            CLASSID = P_CLASSID;
        FOR REC IN PREREQUISITES_CURSOR(V_DEPT_CODE, V_COURSE#) LOOP
            SELECT
                COUNT(*) INTO V_PREREQ_NOT_MET
            FROM
                G_ENROLLMENTS GE
            WHERE
                GE.G_B# = P_B#
                AND GE.CLASSID IN (
                    SELECT
                        CLASSID
                    FROM
                        CLASSES
                    WHERE
                        DEPT_CODE = REC.PRE_DEPT_CODE
                        AND COURSE# = REC.PRE_COURSE#
                )
                AND (GE.SCORE < 65.35
                OR GE.SCORE IS NULL); -- Check if score is less than 65.35
 -- If any prerequisite is not met, raise an error
            DBMS_OUTPUT.PUT_LINE('Value prereq'
                                 || V_PREREQ_NOT_MET);
            IF V_PREREQ_NOT_MET > 0 THEN
                RAISE_APPLICATION_ERROR(-20010, 'Prerequisite not satisfied.');
            END IF;
        END LOOP;

        DBMS_OUTPUT.PUT_LINE('here');
 -- Enroll the student
        INSERT INTO G_ENROLLMENTS (
            G_B#,
            CLASSID,
            SCORE
        ) VALUES (
            P_B#,
            P_CLASSID,
            NULL
        );
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20009, 'Data validation failed.');
    END ENROLL_STUDENT;
 -- procedure to drop student
    PROCEDURE DROP_STUDENT(
        P_B# IN CHAR,
        P_CLASSID IN CHAR
    ) IS
        V_ST_LEVEL       VARCHAR2(10);
        V_YEAR           NUMBER;
        V_SEMESTER       VARCHAR2(8);
        V_ENROLLED_COUNT NUMBER;
        V_CLASS_COUNT    NUMBER;
    BEGIN
 -- Verify the student exists and is a graduate student
        BEGIN
            SELECT
                ST_LEVEL INTO V_ST_LEVEL
            FROM
                STUDENTS
            WHERE
                B# = P_B#;
            IF V_ST_LEVEL NOT IN ('master', 'PhD') THEN
                RAISE_APPLICATION_ERROR(-20002, 'This is not a graduate student.');
            END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20001, 'The B# is invalid.');
        END;
 -- Verify the class exists and is offered in Spring 2021
        BEGIN
            SELECT
                YEAR,
                SEMESTER INTO V_YEAR,
                V_SEMESTER
            FROM
                CLASSES
            WHERE
                CLASSID = P_CLASSID;
            IF V_YEAR != 2021 OR V_SEMESTER != 'Spring' THEN
                RAISE_APPLICATION_ERROR(-20004, 'Only enrollment in the current semester can be dropped.');
            END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20003, 'The classid is invalid.');
        END;
 -- Check if the student is currently enrolled in the class
        SELECT
            COUNT(*) INTO V_ENROLLED_COUNT
        FROM
            G_ENROLLMENTS
        WHERE
            G_B# = P_B#
            AND CLASSID = P_CLASSID;
        IF V_ENROLLED_COUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20005, 'The student is not enrolled in the class.');
        END IF;
 -- Check if this is the only class for this student in Spring 2021
        SELECT
            COUNT(*) INTO V_CLASS_COUNT
        FROM
            G_ENROLLMENTS GE
            JOIN CLASSES C
            ON GE.CLASSID = C.CLASSID
        WHERE
            GE.G_B# = P_B#
            AND C.YEAR = 2021
            AND C.SEMESTER = 'Spring';
        IF V_CLASS_COUNT = 1 THEN
            RAISE_APPLICATION_ERROR(-20006, 'This is the only class for this student in Spring 2021 and cannot be dropped.');
        END IF;
 -- If all checks are passed, delete the enrollment record
        DELETE FROM G_ENROLLMENTS
        WHERE
            G_B# = P_B#
            AND CLASSID = P_CLASSID;
    END DROP_STUDENT;

    PROCEDURE DELETE_STUDENT(
        P_B# IN CHAR
    ) IS
        V_COUNT NUMBER;
    BEGIN
 -- Check if the student exists
        SELECT
            COUNT(*) INTO V_COUNT
        FROM
            STUDENTS
        WHERE
            B# = P_B#;
        IF V_COUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'The B# is invalid.');
        END IF;
 -- Delete the student; cascading deletes will be handled by a trigger
        DELETE FROM STUDENTS
        WHERE
            B# = P_B#;
    END DELETE_STUDENT;

    PROCEDURE DELETE_COURSE(
        P_DEPT_CODE IN VARCHAR2,
        P_COURSE# IN NUMBER
    ) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Attempting to delete course: Dept='
                             || P_DEPT_CODE
                             || ', Course#='
                             || P_COURSE#);
 -- First, delete related entries in g_enrollments by finding all class IDs related to the course
        DELETE FROM G_ENROLLMENTS
        WHERE
            CLASSID IN (
                SELECT
                    CLASSID
                FROM
                    CLASSES
                WHERE
                    DEPT_CODE = P_DEPT_CODE
                    AND COURSE# = P_COURSE#
            );
        DBMS_OUTPUT.PUT_LINE('Deleted related entries from g_enrollments.');
 -- Next, delete from classes
        DELETE FROM CLASSES
        WHERE
            DEPT_CODE = P_DEPT_CODE
            AND COURSE# = P_COURSE#;
        DBMS_OUTPUT.PUT_LINE('Deleted from classes.');
 -- Explicitly delete from prerequisites where the course is a prerequisite or the main course
        DELETE FROM PREREQUISITES
        WHERE
            (DEPT_CODE = P_DEPT_CODE
            AND COURSE# = P_COURSE#)
            OR (PRE_DEPT_CODE = P_DEPT_CODE
            AND PRE_COURSE# = P_COURSE#);
        DBMS_OUTPUT.PUT_LINE('Deleted from prerequisites.');
 -- Finally, delete the course
        DELETE FROM COURSES
        WHERE
            DEPT_CODE = P_DEPT_CODE
            AND COURSE# = P_COURSE#;
        DBMS_OUTPUT.PUT_LINE('Course deleted.');
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Deletion completed successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error during deletion: '
                                 || SQLERRM);
            ROLLBACK;
            RAISE;
    END DELETE_COURSE;

    PROCEDURE DELETE_CLASS(
        P_CLASSID IN VARCHAR2
    ) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Attempting to delete class: ClassID='
                             || P_CLASSID);
 -- First, delete related entries in enrollments for the given class ID
        DELETE FROM G_ENROLLMENTS
        WHERE
            CLASSID = P_CLASSID;
        DBMS_OUTPUT.PUT_LINE('Deleted related entries from g_enrollments.');
 -- Next, delete the class entry itself
        DELETE FROM CLASSES
        WHERE
            CLASSID = P_CLASSID;
        DBMS_OUTPUT.PUT_LINE('Deleted from classes.');
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Deletion completed successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error during deletion: '
                                 || SQLERRM);
            ROLLBACK;
            RAISE;
    END DELETE_CLASS;
END UNIVERSITYDATAPKG;
/