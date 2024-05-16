package com.example.universityapplication.repositories;

import com.example.universityapplication.models.Log;
import oracle.jdbc.OracleTypes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class LogRepository {

    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<Log> rowMapper = new RowMapper<Log>() {
        @Override
        public Log mapRow(ResultSet rs, int rowNum) throws SQLException {
            Log log = new Log();
            log.setLogNumber(rs.getInt("log#"));
            log.setUserName(rs.getString("user_name"));
            log.setOperationTime(rs.getTimestamp("op_time"));
            log.setTableName(rs.getString("table_name"));
            log.setOperation(rs.getString("operation"));
            log.setTupleKeyValue(rs.getString("tuple_keyvalue"));
            return log;
        }
    };

    @Autowired
    public LogRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Log> findAllLogs() {
        return jdbcTemplate.execute(
                (Connection con) -> {
                    CallableStatement cs = con.prepareCall("{ ? = call UniversityDataPkg.get_Logs() }");
                    cs.registerOutParameter(1, OracleTypes.CURSOR);
                    return cs;
                },
                (CallableStatement cs) -> {
                    cs.execute();
                    ResultSet rs = (ResultSet) cs.getObject(1);
                    List<Log> logs = new ArrayList<>();
                    while (rs.next()) {
                        System.out.println(rs.getRow());
                        logs.add(rowMapper.mapRow(rs, rs.getRow()));
                    }
                    rs.close();
                    return logs;
                }
        );
    }
}
