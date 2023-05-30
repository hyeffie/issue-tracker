package com.issuetracker.dto.issue;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class IssueMilestone {
    private int milestoneId;
    private String milestoneName;
    private long countAllIssues;
    private long countAllClosedIssues;
    private int progress;

    public int getProgress() {
        //마일스톤 진행률을 반환합니다.
        if (countAllIssues == 0) {
            return 0;
        }

        return (int)(100 * countAllClosedIssues / countAllIssues);
    }
}
