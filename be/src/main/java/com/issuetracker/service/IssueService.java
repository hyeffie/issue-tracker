package com.issuetracker.service;

import com.issuetracker.dto.issue.AssigneeDto;
import com.issuetracker.dto.issue.IssueCommentDto;
import com.issuetracker.dto.issue.IssueDetailDto;
import com.issuetracker.dto.issue.IssueLabelDto;
import com.issuetracker.repository.IssueRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class IssueService {

    private final IssueRepository issueRepository;

    public IssueDetailDto getIssueDetail(Long issueId) {
        List<AssigneeDto> assigneeList = getAssgineesByIssueId(issueId);
        List<IssueLabelDto> labelList = getLabelListByIssueId(issueId);
        List<IssueCommentDto> commentList = getCommentListByIssueId(issueId);
        return new IssueDetailDto(assigneeList, labelList, commentList);
    }

    private List<AssigneeDto> getAssgineesByIssueId(Long issueId) {
        List<AssigneeDto> assigneeDtoList = issueRepository.findAssigneeListByIssueId(issueId);

        for (AssigneeDto assigneeDto : assigneeDtoList) {
            System.out.println(assigneeDto.getId());
            System.out.println(assigneeDto.getUserName());
            System.out.println(assigneeDto.getProfileUrl());
        }
        return assigneeDtoList;
    }

    private List<IssueLabelDto> getLabelListByIssueId(Long issueId) {
        List<IssueLabelDto> labelList = issueRepository.findLabelListByIssueId(issueId);

        for (IssueLabelDto issueLabelDto : labelList) {
            System.out.println(issueLabelDto.getLabelId());
            System.out.println(issueLabelDto.getLabelName());
            System.out.println(issueLabelDto.getBackgroundColor());
            System.out.println(issueLabelDto.getFontColor());
        }
        return labelList;
    }

    private List<IssueCommentDto> getCommentListByIssueId(Long issueId) {
        List<IssueCommentDto> commentList = issueRepository.findCommentListByIssueId(issueId);

        for (IssueCommentDto issueCommentDto : commentList) {
            System.out.println(issueCommentDto.getCommentId());
            System.out.println(issueCommentDto.getUserId());
            System.out.println(issueCommentDto.getUserName());
            System.out.println(issueCommentDto.getProfileUrl());
            System.out.println(issueCommentDto.getContent());
            System.out.println(issueCommentDto.getCreatedAt());
            System.out.println(issueCommentDto.getUpdatedAt());
        }

        return commentList;
    }
}
