package com.issuetracker.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.issuetracker.dto.TestDto;

@RestController
public class TestController {
    @GetMapping("api/hello")
    public TestDto mapping() {
        return new TestDto(3, "test");
    }

}
