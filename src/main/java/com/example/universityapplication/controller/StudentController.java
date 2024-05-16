package com.example.universityapplication.controller;

import com.example.universityapplication.models.Enrollment;
import com.example.universityapplication.models.Student;
import com.example.universityapplication.services.EnrollmentService;
import com.example.universityapplication.services.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/students")
public class StudentController {

    private final StudentService studentService;
    private final EnrollmentService enrollmentService;
    @Autowired
    public StudentController(StudentService studentService, EnrollmentService enrollmentService) {
        this.studentService = studentService;
        this.enrollmentService = enrollmentService;
    }


    @GetMapping
    public String studentsPage() {
        return "students";
    }

    @GetMapping("/enrollment")
    public String enrollmentsPage() {return "enrollment";}

    @GetMapping("/view")
    public ResponseEntity<List<Student>> getAllStudents() {
        List<Student> students = studentService.getAllStudents();
        if (students.isEmpty()) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.ok(students);
    }


    @GetMapping("/view/enrollment")
    public ResponseEntity<List<Enrollment>> getAllEnrollments() {
        List<Enrollment> enrollments = enrollmentService.getAllEnrollments();
        if (enrollments.isEmpty()) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.ok(enrollments);
    }

    @PostMapping("/insert")
    public ResponseEntity<String> addStudent(@RequestBody Student student) {
        String result = studentService.addStudent(student);
        if (result.contains("successfully")) {
            return ResponseEntity.ok(result);
        } else {
            return ResponseEntity.badRequest().body(result);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteStudent(@PathVariable String id) {
        System.out.println(id +     " is deleted");
        String result = studentService.deleteStudent(id);
        if (result.equals("Success")) {
            return ResponseEntity.ok("Student deleted successfully");
        } else {
            return ResponseEntity.badRequest().body(result);
        }
    }

    @PostMapping("/enroll/{stid}/{clid}")
    public ResponseEntity<String> enrollStudent(@PathVariable String stid, @PathVariable String clid){
        String result = studentService.enrollStudent(stid, clid);
        if (result.equals("Success")) {
            System.out.println(stid + "is enrolled in class " + clid);
            return ResponseEntity.ok("Student enrolled successfully");
        } else {
            return ResponseEntity.badRequest().body(result);
        }
    }

    @PostMapping("/drop/{stid}/{clid}")
    public ResponseEntity<String> dropStudent(@PathVariable String stid, @PathVariable String clid) {
        String result = studentService.dropStudent(stid, clid);
        if (result.equals("Success")) {
            System.out.println(stid + " has been dropped from class " + clid);
            return ResponseEntity.ok("Student dropped from class successfully");
        } else {
            return ResponseEntity.badRequest().body(result);
        }
    }


}
