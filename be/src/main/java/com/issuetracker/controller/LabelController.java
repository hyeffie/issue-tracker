package com.issuetracker.controller;

import java.sql.SQLException;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.issuetracker.dto.label.LabelDto;
import com.issuetracker.dto.label.LabelListDto;
import com.issuetracker.service.LabelService;

import lombok.RequiredArgsConstructor;

@Slf4j
@RestController
@RequiredArgsConstructor
public class LabelController {

    private final LabelService labelService;

    @GetMapping("/api/labels")
    public LabelListDto getLabels() {
        return labelService.findAllLabels();
    }

    @PostMapping("/api/labels")
    public void create(@RequestBody LabelDto labelDto) {
        labelService.createLabel(labelDto);
    }

    @DeleteMapping("/api/labels/{labelId}")
    public void delete(@PathVariable int labelId) {
        labelService.deleteLabelById(labelId);
    }

    @PatchMapping("/api/labels/{labelId}")
    public void update(@PathVariable int labelId, @RequestBody LabelDto labelDto) {
        labelService.updateLabel(labelId, labelDto);
    }

    @ExceptionHandler(SQLException.class)
    public void sqlException() {
        log.debug("SQL 예외 발생");
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public void labelException() {
        log.debug("존재하지 않는 Issue입니다.");
    }
}
