package com.issuetracker.dto.issueList;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class FilterMilestoneProgressDto {
    private int milestoneId;
    private String milestoneName;
    private long countAllIssues;
    private long countAllClosedIssues;
    private int progress;
}

