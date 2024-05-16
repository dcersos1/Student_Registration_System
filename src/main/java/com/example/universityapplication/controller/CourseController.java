package com.example.universityapplication.controller;

import com.example.universityapplication.models.Course;
import com.example.universityapplication.services.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/courses")
public class CourseController {

    private final CourseService courseService;

    @Autowired
    public CourseController(CourseService courseService) {
        this.courseService = courseService;
    }

    @GetMapping
    public String coursesPage() {
        return "courses";
    }

    @GetMapping("/view")
    public ResponseEntity<List<Course>> getAllCourses() {
        List<Course> courses = courseService.getAllCourses();
        if (courses.isEmpty()) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.ok(courses);
    }

    @PostMapping("/insert")
    public ResponseEntity<String> addCourse(@RequestBody Course course) {
        String result = courseService.addCourse(course);
        if (result.contains("successfully")) {
            return ResponseEntity.ok(result);
        } else {
            return ResponseEntity.badRequest().body(result);
        }
    }

    @DeleteMapping("/{deptCode}/{courseNumber}")
    public ResponseEntity<String> deleteCourse(@PathVariable String deptCode, @PathVariable int courseNumber) {
        String result = courseService.deleteCourse(deptCode, courseNumber);
        if (result.equals("Course successfully deleted")) {
            return ResponseEntity.ok("Course deleted successfully");
        } else {
            return ResponseEntity.badRequest().body(result);
        }
    }
}
