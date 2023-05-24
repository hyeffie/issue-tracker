package com.issuetracker.dto.issue;

import lombok.Getter;

@Getter
public class IssueMilestone {
    private int milestoneId;
    private String milestoneName;
    private int countAllIssues;
    private int countAllClosedIssues;
    private int progress;

    public int getProgress() {
        //마일스톤 진행률을 반환합니다.
        if (countAllIssues == 0) {
            return 0;
        }

        return 100 * countAllClosedIssues / countAllIssues;
    }
}
