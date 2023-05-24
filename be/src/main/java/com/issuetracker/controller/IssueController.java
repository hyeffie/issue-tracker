package com.issuetracker.controller;

import com.issuetracker.dto.issueList.IssueStatusListDto;
import org.springframework.web.bind.annotation.*;

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

    @PatchMapping("/api/issues/{issueId}")
    public void update(@RequestBody IssuePostDto labelPostDto, @PathVariable long issueId) {
        issueService.modifyIssue(labelPostDto, issueId);
    }

    @DeleteMapping("/api/issues/{issueId}")
    public void delete(@PathVariable long issueId) {
        issueService.deleteIssue(issueId);
    }

    @PatchMapping("/api/issues")
    public void changeIssueStatus(@RequestBody IssueStatusListDto issueStatusListDto) {
        issueService.changeIssueStatus(issueStatusListDto);
    }
}
