package com.issuetracker.dto.issueList;

import org.springframework.data.relational.core.mapping.Column;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class FilterMilestoneDto {
    @Column("id")
    private int milestoneId;
    @Column("name")
    private String milestoneName;
    @Column("description")
    private String description;
}

