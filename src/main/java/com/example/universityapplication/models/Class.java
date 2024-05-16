package com.example.universityapplication.models;

public class Class {

    private String classId;


    private String deptCode;


    private Integer courseNumber;


    private Integer sectionNumber;


    private Integer year;


    private String semester;


    private Integer limit;

    private Integer classSize;


    private String room;

    // Getters and Setters
    public String getClassId() { return classId; }
    public void setClassId(String classId) { this.classId = classId; }

    public String getDeptCode() { return deptCode; }
    public void setDeptCode(String deptCode) { this.deptCode = deptCode; }

    public Integer getCourseNumber() { return courseNumber; }
    public void setCourseNumber(Integer courseNumber) { this.courseNumber = courseNumber; }

    public Integer getSectionNumber() { return sectionNumber; }
    public void setSectionNumber(Integer sectionNumber) { this.sectionNumber = sectionNumber; }

    public Integer getYear() { return year; }
    public void setYear(Integer year) { this.year = year; }

    public String getSemester() { return semester; }
    public void setSemester(String semester) { this.semester = semester; }

    public Integer getLimit() { return limit; }
    public void setLimit(Integer limit) { this.limit = limit; }

    public Integer getClassSize() { return classSize; }
    public void setClassSize(Integer classSize) { this.classSize = classSize; }

    public String getRoom() { return room; }
    public void setRoom(String room) { this.room = room; }
}
