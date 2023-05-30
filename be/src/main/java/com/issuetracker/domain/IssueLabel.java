package com.issuetracker.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Table("issue_label")
public class IssueLabel {
    @Id
    private Long id;
    private Long issueId;
    private Integer labelId;

    public static IssueLabel attach(Long issueId, Integer labelId) {
        return new IssueLabel(null, issueId, labelId);
    }
}
