package com.example.universityapplication.services;


import com.example.universityapplication.models.Log;
import com.example.universityapplication.repositories.LogRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LogService {
    private final LogRepository logRepository;

    @Autowired
    public LogService(LogRepository logRepository) {this.logRepository = logRepository;}

    public List<Log> getAllLogs(){return logRepository.findAllLogs();}
}
