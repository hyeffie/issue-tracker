package com.issuetracker.service;

import com.issuetracker.dto.issue.AssigneeDto;
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
        return new IssueDetailDto(assigneeList, labelList);
    }

    private List<AssigneeDto> getAssgineesByIssueId(Long issueId) {
        List<AssigneeDto> assigneeDtoList = issueRepository.findAssigneesByIssueId(issueId);

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
}
