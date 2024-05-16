package com.example.universityapplication.services;

import com.example.universityapplication.repositories.StudentRepository;
import com.example.universityapplication.models.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentService {
    private final StudentRepository studentRepository;

    @Autowired
    public StudentService(StudentRepository studentRepository) {
        this.studentRepository = studentRepository;
    }

    // Retrieve all students
    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    // Add a new student and return a message indicating the result
    public String addStudent(Student student) {
        return studentRepository.addStudent(student);
    }

    // Delete a student by ID and return a message indicating the result
    public String deleteStudent(String id) {
        return studentRepository.deleteStudent(id);
    }

    public  String enrollStudent(String stid, String clid){
        return studentRepository.enrollStudent(stid, clid);
    }

    public String dropStudent(String stid, String clid) {
        return studentRepository.dropStudent(stid, clid);
    }

}
