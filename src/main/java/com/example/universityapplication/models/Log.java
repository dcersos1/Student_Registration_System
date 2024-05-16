package com.example.universityapplication.models;


import java.util.Date;

public class Log {

    private int logNumber;

    private String userName;

    private Date operationTime;

    private String tableName;


    private String operation;

    private String tupleKeyValue;

    // Getters and Setters
    public int getLogNumber() {
        return logNumber;
    }

    public void setLogNumber(int logNumber) {
        this.logNumber = logNumber;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Date getOperationTime() {
        return operationTime;
    }

    public void setOperationTime(Date operationTime) {
        this.operationTime = operationTime;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getOperation() {
        return operation;
    }

    public void setOperation(String operation) {
        this.operation = operation;
    }

    public String getTupleKeyValue() {
        return tupleKeyValue;
    }

    public void setTupleKeyValue(String tupleKeyValue) {
        this.tupleKeyValue = tupleKeyValue;
    }
}
