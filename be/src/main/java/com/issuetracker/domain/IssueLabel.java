package com.issuetracker.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Table("issue_label")
public class IssueLabel {
    @Id
    private Long id;
    @Column("issue_id")
    private Long issueId;
    @Column("label_id")
    private Integer labelId;

    public static IssueLabel attach(Long issueId, Integer labelId) {
        return new IssueLabel(null, issueId, labelId);
    }
}
