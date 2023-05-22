package com.issuetracker.dto.issueList;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
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
