package com.issuetracker.controller;

import com.issuetracker.dto.issue.IssueDetailPageDto;
import com.issuetracker.service.IssueService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class IssueController {

    private final IssueService issueService;

    @GetMapping("/api/issues/{issueId}")
    public IssueDetailPageDto getIssueDetail(@PathVariable Long issueId) {
        return issueService.getIssueDetail(issueId);
    }
}
