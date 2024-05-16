package com.example.universityapplication.repositories;
import com.example.universityapplication.models.Student;
import oracle.jdbc.OracleTypes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class StudentRepository {

    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<Student> rowMapper = new RowMapper<Student>() {
        @Override
        public Student mapRow(ResultSet rs, int rowNum) throws SQLException {
            Student student = new Student();
            student.setId(rs.getString("B#"));
            student.setFirstName(rs.getString("FIRST_NAME"));
            student.setLastName(rs.getString("LAST_NAME"));
            student.setStLevel(rs.getString("ST_LEVEL"));
            student.setGpa(rs.getDouble("GPA"));
            student.setEmail(rs.getString("EMAIL"));
            student.setBdate(rs.getDate("BDATE"));
            return student;
        }
    };

    @Autowired
    public StudentRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Student> findAll() {
        return jdbcTemplate.execute(
                (Connection con) -> {
                    CallableStatement cs = con.prepareCall("{ ? = call UniversityDataPkg.get_Students() }");
                    cs.registerOutParameter(1, OracleTypes.CURSOR);
                    return cs;
                },
                (CallableStatement cs) -> {
                    cs.execute();
                    ResultSet rs = (ResultSet) cs.getObject(1);
                    List<Student> students = new ArrayList<>();
                    while (rs.next()) {
                        students.add(rowMapper.mapRow(rs, rs.getRow()));
                    }
                    rs.close();
                    return students;
                }
        );
    }

    public String addStudent(Student student) {
        String sql = "INSERT INTO STUDENTS (B#, FIRST_NAME, LAST_NAME, ST_LEVEL, GPA, EMAIL, BDATE) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            jdbcTemplate.update(sql,
                    student.getId(),
                    student.getFirstName(),
                    student.getLastName(),
                    student.getStLevel(),
                    student.getGpa(),
                    student.getEmail(),
                    student.getBdate());
            return "Student added successfully";
        } catch (DataAccessException e) {
            // Log the exception here: depending on your logging framework, e.g., SLF4J, Log4j
            // Log.error("Error adding student to the database", e);
            return "Error adding student: " + e.getMessage();
        }
    }

    public String deleteStudent(String id) {
        try {
            jdbcTemplate.update("CALL UniversityDataPkg.delete_student(?)", id);
            return "Success";
        } catch (DataAccessException e) {
            System.out.println("Error deleting student: " + e.getMessage());
            return "Error deleting student: " + e.getMessage();
        }
    }

    public String enrollStudent(String stid, String clid){
        try {
            jdbcTemplate.update("CALL UniversityDataPkg.enroll_student(?,?)", stid,clid);
            return "Success";
        } catch (DataAccessException e) {
            System.out.println("Error deleting student: " + e.getMessage());
            return "Error deleting student: " + e.getMessage();
        }
    }

    public String dropStudent(String stid, String clid) {
        try {
            jdbcTemplate.update("CALL UniversityDataPkg.drop_student(?,?)", stid, clid);
            return "Success";
        } catch (DataAccessException e) {
            System.out.println("Error dropping student: " + e.getMessage());
            return "Error dropping student: " + e.getMessage();
        }
    }

}
