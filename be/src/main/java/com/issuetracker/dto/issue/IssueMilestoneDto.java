package com.issuetracker.dto.issue;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class IssueMilestoneDto {
    private int milestoneId;
    private String milestoneName;
    private int countAllIssues;
    private int countAllClosedIssues;
    private int progress;
    // public int getProgress() {
    //     return 100 * countAllClosedIssues / countAllIssues;
    // }
}
