package com.issuetracker.controller;

import com.issuetracker.dto.issueList.Filter;
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

    @GetMapping(value = {"/api/issues", "/api"})
    public IssueListDto listIssues(@ModelAttribute Filter filterDto) {

        return labelService.fetchMain(filterDto);
    }
}
