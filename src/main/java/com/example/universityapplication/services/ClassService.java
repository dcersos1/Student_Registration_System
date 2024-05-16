package com.example.universityapplication.services;

import com.example.universityapplication.models.Class;
import com.example.universityapplication.repositories.ClassRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClassService {
    private final ClassRepository classRepository;

    @Autowired
    public ClassService(ClassRepository classRepository) {
        this.classRepository = classRepository;
    }

    // Retrieve all classes
    public List<Class> getAllClasses() {
        return classRepository.findAll();
    }

    // Add a new class and return a message indicating the result
    public String addClass(Class cls) {
        return classRepository.addClass(cls);
    }

    // Delete a class by ID and return a message indicating the result
    public String deleteClass(String classId) {
        return classRepository.deleteClass(classId);
    }
}
