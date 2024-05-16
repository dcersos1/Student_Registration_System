package com.example.universityapplication.repositories;

import com.example.universityapplication.models.Class;
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
public class ClassRepository {

    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<Class> rowMapper = new RowMapper<Class>() {
        @Override
        public Class mapRow(ResultSet rs, int rowNum) throws SQLException {
            Class cls = new Class();
            cls.setClassId(rs.getString("classid"));
            cls.setDeptCode(rs.getString("dept_code"));
            cls.setCourseNumber(rs.getInt("course#"));
            cls.setSectionNumber(rs.getInt("sect#"));
            cls.setYear(rs.getInt("year"));
            cls.setSemester(rs.getString("semester"));
            cls.setLimit(rs.getInt("limit"));
            cls.setClassSize(rs.getInt("class_size"));
            cls.setRoom(rs.getString("room"));
            return cls;
        }
    };

    @Autowired
    public ClassRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Class> findAll() {
        return jdbcTemplate.execute(
                (Connection con) -> {
                    CallableStatement cs = con.prepareCall("{ ? = call UniversityDataPkg.get_Classes() }");
                    cs.registerOutParameter(1, OracleTypes.CURSOR);
                    return cs;
                },
                (CallableStatement cs) -> {
                    cs.execute();
                    ResultSet rs = (ResultSet) cs.getObject(1);
                    List<Class> classes = new ArrayList<>();
                    while (rs.next()) {
                        classes.add(rowMapper.mapRow(rs, rs.getRow()));
                    }
                    rs.close();
                    System.out.println(classes);
                    return classes;
                }
        );
    }

    public String addClass(Class cls) {
        String sql = "INSERT INTO CLASSES (classid, dept_code, course#, sect#, year, semester, limit, class_size, room) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            jdbcTemplate.update(sql,
                    cls.getClassId(),
                    cls.getDeptCode(),
                    cls.getCourseNumber(),
                    cls.getSectionNumber(),
                    cls.getYear(),
                    cls.getSemester(),
                    cls.getLimit(),
                    cls.getClassSize(),
                    cls.getRoom());
            return "Class added successfully";
        } catch (DataAccessException e) {
            return "Error adding class: " + e.getMessage();
        }
    }

    public String deleteClass(String classId) {
        try {
            jdbcTemplate.update("CALL UniversityDataPkg.delete_class(?)", classId);
            return "Class successfully deleted";
        } catch (DataAccessException e) {
            return "Error deleting class: " + e.getMessage();
        }
    }
}
