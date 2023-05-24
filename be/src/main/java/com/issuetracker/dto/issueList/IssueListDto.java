package com.issuetracker.dto.issueList;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class IssueListDto {
    private List<IssueDto> issues;
    private List<FilterUserDto> userList;
    private List<FilterLabelDto> labelList;
    private List<FilterMilestoneDto> milestoneList;
    private int countAllLabels;
    private int countAllMilestones;
    private long countOpenedIssues;
    private long countClosedIssues;
}
