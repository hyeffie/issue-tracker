package com.issuetracker.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class IssueListDto {
    private List<IssueDto> issues;
    private List<FilterUserDto> userList;
    private List<FilterLabelDto> labelList;
    private List<FilterMilestoneDto> milestoneList;
    private int countAllLabels;
    private int countAllMilestones;
    private int countOpenedIssues;
    private int countClosedIssues;
}
