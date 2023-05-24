package com.issuetracker.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.issuetracker.dto.issue.IssueDetailPageDto;
import com.issuetracker.dto.issue.IssuePostDto;
import com.issuetracker.service.IssueService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class IssueController {

    private final IssueService issueService;

    @GetMapping("/api/issues/{issueId}")
    public IssueDetailPageDto getIssueDetail(@PathVariable long issueId) {
        return issueService.getIssueDetail(issueId);
    }

    @PostMapping("/api/issues")
    public void post(@RequestBody IssuePostDto labelPostDto) {
        issueService.createIssue(labelPostDto);
    }
}
