package com.example.universityapplication.repositories;

import com.example.universityapplication.models.Course;
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
public class CourseRepository {

    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<Course> rowMapper = new RowMapper<Course>() {
        @Override
        public Course mapRow(ResultSet rs, int rowNum) throws SQLException {
            Course course = new Course();
            course.setDeptCode(rs.getString("DEPT_CODE"));
            course.setCourseNumber(rs.getInt("COURSE#"));
            course.setTitle(rs.getString("TITLE"));
            return course;
        }
    };

    @Autowired
    public CourseRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Course> findAll() {
        return jdbcTemplate.execute(
                (Connection con) -> {
                    CallableStatement cs = con.prepareCall("{ ? = call UniversityDataPkg.get_Courses() }");
                    cs.registerOutParameter(1, OracleTypes.CURSOR);
                    return cs;
                },
                (CallableStatement cs) -> {
                    cs.execute();
                    ResultSet rs = (ResultSet) cs.getObject(1);
                    List<Course> courses = new ArrayList<>();
                    while (rs.next()) {
                        courses.add(rowMapper.mapRow(rs, rs.getRow()));
                    }
                    rs.close();
                    return courses;
                }
        );
    }

    public String addCourse(Course course) {
        String sql = "INSERT INTO COURSES (DEPT_CODE, COURSE#, TITLE) " +
                "VALUES (?, ?, ?)";
        try {
            jdbcTemplate.update(sql,
                    course.getDeptCode(),
                    course.getCourseNumber(),
                    course.getTitle());
            return "Course added successfully";
        } catch (DataAccessException e) {
            // Log the exception here: depending on your logging framework, e.g., SLF4J, Log4j
            // Log.error("Error adding course to the database", e);
            return "Error adding course: " + e.getMessage();
        }
    }

    public String deleteCourse(String deptCode, int courseNumber) {
        try {
            jdbcTemplate.update("CALL UniversityDataPkg.delete_course(?, ?)", deptCode, courseNumber);
            return "Course successfully deleted";
        } catch (DataAccessException e) {
            System.out.println("Error deleting course: " + e.getMessage());
            return "Error deleting course: " + e.getMessage();
        }
    }
}
