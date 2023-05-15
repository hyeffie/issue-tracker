package com.issuetracker.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class FilterMilestoneDto {
    private int milestoneId;
    private String milestoneName;
    private String description;
    private int countAllMilestones;
    private int countAllClosedMilestones;
}

