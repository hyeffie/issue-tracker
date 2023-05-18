package com.issuetracker.dto.issue;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.data.relational.core.mapping.Column;

@Data
@AllArgsConstructor
public class IssueMilestoneDto {
    @Column("id")
    private Integer milestoneId;
    @Column("name")
    private String milestoneName;
    @Column("countAllIssues")
    private Integer countAllIssues;
    @Column("countAllClosedIssues")
    private Integer countAllClosedIssues;
    private Integer progress;

    public Integer getProgress() {
        return 100 * countAllClosedIssues / countAllIssues;
    }
}
