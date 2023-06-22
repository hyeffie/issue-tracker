package com.issuetracker.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.issuetracker.dto.issue.IssueDetailPageDto;
import com.issuetracker.dto.issue.IssuePostDto;
import com.issuetracker.dto.issueList.IssueFormDto;
import com.issuetracker.dto.issueList.IssueStatusListDto;
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
    public void updateIssue(@RequestBody IssuePostDto issuePostDto, @PathVariable long issueId) {
        issueService.modifyIssue(issuePostDto, issueId);
    }

    @PatchMapping("/api/issues/{issueId}/title")
    public void updateTitle(@RequestBody Map<String, String> map, @PathVariable long issueId) {
        issueService.modifyIssueTitle(map.get("title"), issueId);
    }

    @PatchMapping("/api/issues/{issueId}/content")
    public void updateContent(@RequestBody Map<String, String> map, @PathVariable long issueId) {
        issueService.modifyIssueContent(map.get("content"), issueId);
    }

    @PatchMapping("/api/issues/{issueId}/assignees")
    public void updateAssignees(@RequestBody Map<String, List<Map<String, Long>>> map, @PathVariable long issueId) {
        List<Long> userIdList = new ArrayList<>();
        map.get("userList").stream().forEach(e -> userIdList.add(e.get("userId")));
        issueService.modifyAssigneesOnIssue(issueId, userIdList);

    }

    @PatchMapping("/api/issues/{issueId}/labels")
    public void updateLabels(@RequestBody Map<String, List<Map<String, Integer>>> map, @PathVariable long issueId) {
        List<Integer> labelIdList = new ArrayList<>();
        map.get("labelList").stream().forEach(e -> labelIdList.add(e.get("labelId")));
        issueService.modifyLabelsOnIssue(issueId, labelIdList);
    }

    @PatchMapping("/api/issues/{issueId}/milestones")
    public void updateMilestone(@RequestBody Map<String, Integer> map, @PathVariable long issueId) {
        issueService.modifyMilestoneOnIssue(map.get("milestoneId"), issueId);
    }

    @DeleteMapping("/api/issues/{issueId}")
    public void delete(@PathVariable long issueId) {
        issueService.deleteIssue(issueId);
    }

    @PatchMapping("/api/issues")
    public void changeIssueStatus(@RequestBody IssueStatusListDto issueStatusListDto) {
        issueService.changeIssueStatus(issueStatusListDto);
    }

    @PatchMapping("/api/issues/{issueId}/status")
    public void changeSpecificIssueStatus(@PathVariable long issueId, @RequestBody Map<String, Boolean> map) {
        issueService.changeSpecificIssueStatus(issueId, map.get("isOpen"));
    }

    @GetMapping("/api/issues/create")
    public IssueFormDto getIssueForm() {
        return issueService.getIssueForm();
    }
}
