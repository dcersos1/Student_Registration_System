package com.example.universityapplication.repositories;

import com.example.universityapplication.models.Enrollment;
import oracle.jdbc.OracleTypes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class EnrollmentRepository {

    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<Enrollment> rowMapper = new RowMapper<Enrollment>(){
        @Override
        public Enrollment mapRow(ResultSet rs, int rowNum) throws SQLException {
                Enrollment enrollment = new Enrollment();
                enrollment.setClassId(rs.getString("classid"));
                enrollment.setScore(rs.getBigDecimal("score"));
                enrollment.setStudentId(rs.getString("g_B#"));
                return enrollment;
            }
    };

    @Autowired
    public EnrollmentRepository(JdbcTemplate jdbcTemplate){this.jdbcTemplate = jdbcTemplate;}

    public List<Enrollment> findAll() {
        return jdbcTemplate.execute(
                (Connection con) -> {
                    CallableStatement cs = con.prepareCall("{ ? = call UniversityDataPkg.get_g_enrollments() }");
                    cs.registerOutParameter(1, OracleTypes.CURSOR);
                    return cs;
                },
                (CallableStatement cs) -> {
                    cs.execute();
                    ResultSet rs = (ResultSet) cs.getObject(1);
                    List<Enrollment> enrollments = new ArrayList<>();
                    while (rs.next()) {
                        enrollments.add(rowMapper.mapRow(rs, rs.getRow()));
                    }
                    rs.close();
                    return enrollments;
                }
        );
    }
}