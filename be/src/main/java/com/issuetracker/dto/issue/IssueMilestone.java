package com.issuetracker.dto.issue;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;

import lombok.Getter;

@Getter
public class IssueMilestone {
    @Id
    @Column("id")
    private int milestoneId;
    @Column("name")
    private String milestoneName;
    @Column("countAllIssues")
    private int countAllIssues;
    @Column("countAllClosedIssues")
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
