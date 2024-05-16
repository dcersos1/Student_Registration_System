package com.example.universityapplication.controller;
import com.example.universityapplication.models.Log;
import com.example.universityapplication.services.LogService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/logs")
public class LogController {
    private final LogService logService;

    @Autowired
    public LogController(LogService logService) {
        this.logService = logService;
    }

    @GetMapping
    public String LogsPage() {
        return "logs";
    }

    @GetMapping("/view")
    public ResponseEntity<List<Log>> getAllLogs() {
        List<Log> Logs = logService.getAllLogs();

        if (Logs.isEmpty()) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.ok(Logs);
    }
}
