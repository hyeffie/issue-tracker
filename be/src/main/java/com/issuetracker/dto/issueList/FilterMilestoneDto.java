package com.issuetracker.dto.issueList;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class FilterMilestoneDto {
    private int milestoneId;
    private String milestoneName;
    private String description;
}

