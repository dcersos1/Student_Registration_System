package com.example.universityapplication.models;

import java.sql.Date;


public class Student {

    private String id; // Assuming B# is the ID in your DB

    private String firstName;
    private String lastName;
    private String stLevel;
    private Double gpa;
    private String email;
    private Date bdate;

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public String getStLevel() { return stLevel; }
    public void setStLevel(String stLevel) { this.stLevel = stLevel; }
    public Double getGpa() { return gpa; }
    public void setGpa(Double gpa) { this.gpa = gpa; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public Date getBdate() { return bdate; }
    public void setBdate(Date bdate) { this.bdate = bdate; }
}
