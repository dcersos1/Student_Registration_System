package com.example.universityapplication.services;

import com.example.universityapplication.repositories.CourseRepository;
import com.example.universityapplication.models.Course;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CourseService {
    private final CourseRepository courseRepository;

    @Autowired
    public CourseService(CourseRepository courseRepository) {
        this.courseRepository = courseRepository;
    }

    // Retrieve all courses
    public List<Course> getAllCourses() {
        return courseRepository.findAll();
    }

    // Add a new course and return a message indicating the result
    public String addCourse(Course course) {
        if (course == null || course.getDeptCode() == null || course.getTitle() == null) {
            return "Invalid course data";
        }
        return courseRepository.addCourse(course);
    }

    // Delete a course by department code and course number and return a message indicating the result
    public String deleteCourse(String deptCode, int courseNumber) {
        if (deptCode == null || deptCode.trim().isEmpty() || courseNumber <= 0) {
            return "Invalid course identifier";
        }
        return courseRepository.deleteCourse(deptCode, courseNumber);
    }
}
