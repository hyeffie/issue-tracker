package com.issuetracker.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Table("assignee")
public class Assignee {
    @Id
    private Long id;
    @Column("issue_id")
    private Long issueId;
    @Column("user_id")

    private Long userId;

    public static Assignee assign(Long issueId, Long userId) {
        return new Assignee(null, issueId, userId);
    }
}
