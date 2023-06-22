package com.issuetracker.dto.milestone;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class MilestoneDto {
    private int milestoneId;
    private String name;
    private String description;
    private LocalDateTime completedAt;
    private Boolean isOpen;
    private long countAllOpenedIssues;
    private long countAllClosedIssues;
    private int progress;
}
