package com.example.universityapplication.controller;

import com.example.universityapplication.models.Class;
import com.example.universityapplication.services.ClassService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/classes")
public class ClassController {

    private final ClassService classService;

    @Autowired
    public ClassController(ClassService classService) {
        this.classService = classService;
    }

    @GetMapping
    public String classesPage() {
        return "classes";
    }

    @GetMapping("/view")
    public ResponseEntity<List<Class>> getAllClasses() {
        List<Class> classes = classService.getAllClasses();
        System.out.println("here");
        if (classes.isEmpty()) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.ok(classes);
    }

    @PostMapping("/insert")
    public ResponseEntity<String> addClass(@RequestBody Class cls) {
        String result = classService.addClass(cls);
        if (result.contains("successfully")) {
            return ResponseEntity.ok(result);
        } else {
            return ResponseEntity.badRequest().body(result);
        }
    }

    @DeleteMapping("/{classId}")
    public ResponseEntity<String> deleteClass(@PathVariable String classId) {
        String result = classService.deleteClass(classId);
        if (result.equals("Class successfully deleted")) {
            return ResponseEntity.ok("Class successfully deleted ");
        } else {
            return ResponseEntity.badRequest().body(result);
        }
    }
}
