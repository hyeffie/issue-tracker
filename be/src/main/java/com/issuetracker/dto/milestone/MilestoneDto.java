package com.issuetracker.dto.milestone;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class MilestoneDto {
    private int milestoneId;
    private String name;
    private String description;
    private LocalDateTime completedAt;
    private long countAllIssues;
    private long countAllClosedIssues;
    private int progress;
}
