package com.issuetracker.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.issuetracker.dto.IssueListDto;
import com.issuetracker.service.LabelService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class IssueListController {

    private final LabelService labelService;

    @GetMapping("/api/")
    public IssueListDto home() {
        labelService.getIssueLabels();

        return null;
    }


}
