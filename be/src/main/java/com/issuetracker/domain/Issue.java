package com.issuetracker.domain;

import java.time.LocalDateTime;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import com.issuetracker.dto.issue.IssuePostDto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Table("issue")
public class Issue {
    @Id
    private Long id;
    @Column("user_id")
    private Long userId;
    @Column("milestone_id")
    private Integer milestoneId;
    private String title;
    private String content;
    private Boolean opened;
    @Column("created_at")
    private LocalDateTime createdAt;
    @Column("closed_at")
    private LocalDateTime closedAt;
    @Column("deleted_at")
    private LocalDateTime deletedAt;

    public static Issue createIssue(IssuePostDto issuePostDto) {
        return new Issue(null, issuePostDto.getUserId(), issuePostDto.getMilestoneId(), issuePostDto.getTitle(),
                issuePostDto.getContent(), true, LocalDateTime.now(), null, null);
    }

    public static Issue updateIssue(IssuePostDto issuePostDto, Issue issueUnmodified, long id) {
        return new Issue(id, issueUnmodified.getUserId(), issuePostDto.getMilestoneId(), issuePostDto.getTitle(),
                issuePostDto.getContent(), issueUnmodified.getOpened(), LocalDateTime.now(), issueUnmodified.getClosedAt(), issueUnmodified.getDeletedAt());
    }

    public static Issue deleteIssue(Issue issue) {
        return new Issue(issue.getId(), issue.getUserId(), issue.getMilestoneId(), issue.getTitle(),
                issue.getContent(), issue.getOpened(), issue.getCreatedAt(), issue.getClosedAt(), LocalDateTime.now());
    }
}
