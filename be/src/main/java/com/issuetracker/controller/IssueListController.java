package com.issuetracker.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.issuetracker.dto.issueList.IssueListDto;
import com.issuetracker.service.IssueListService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class IssueListController {

    private final IssueListService labelService;

    @GetMapping("/api/")
    public IssueListDto home() {
        IssueListDto issueListDto = labelService.fetchMain();

        return issueListDto;
    }


}
