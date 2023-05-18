package com.issuetracker.service;

import com.issuetracker.dto.issue.*;
import com.issuetracker.repository.IssueRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class IssueService {

    private final IssueRepository issueRepository;

    public IssueDetailDto getIssueDetail(Long issueId) {
        IssueDto issue = getIssueByIssueId(issueId);
        List<AssigneeDto> assigneeList = getAssgineesByIssueId(issueId);
        List<IssueLabelDto> labelList = getLabelListByIssueId(issueId);
        List<IssueCommentDto> commentList = getCommentListByIssueId(issueId);
        IssueMilestoneDto milestone = getMilestoneByIssueId(issueId);
        return new IssueDetailDto(issue, milestone, labelList, assigneeList, commentList);
    }

    private IssueDto getIssueByIssueId(Long issueId) {
        return issueRepository.findIssueByIssueId(issueId);
    }

    private List<AssigneeDto> getAssgineesByIssueId(Long issueId) {
        return issueRepository.findAssigneeListByIssueId(issueId);
    }

    private List<IssueLabelDto> getLabelListByIssueId(Long issueId) {
        return issueRepository.findLabelListByIssueId(issueId);
    }

    private List<IssueCommentDto> getCommentListByIssueId(Long issueId) {
        return issueRepository.findCommentListByIssueId(issueId);
    }

    private IssueMilestoneDto getMilestoneByIssueId(Long issueId) {
        return issueRepository.findMilestoneByIssueId(issueId);
    }
}
