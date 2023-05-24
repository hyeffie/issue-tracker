package com.issuetracker.controller;

import com.issuetracker.dto.issueList.FilterDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RestController;

import com.issuetracker.dto.issueList.IssueListDto;
import com.issuetracker.service.IssueListService;

import lombok.RequiredArgsConstructor;

@Slf4j
@RestController
@RequiredArgsConstructor
public class IssueListController {

    private final IssueListService labelService;

    @GetMapping("/api/issues")
    public IssueListDto listIssues(@ModelAttribute FilterDto filterDto) {
        IssueListDto issueListDto = labelService.fetchMain(filterDto);

        return issueListDto;
    }

    @GetMapping("/api")
    public IssueListDto home(@ModelAttribute FilterDto filterDto) {
        return listIssues(filterDto);
    }
}
