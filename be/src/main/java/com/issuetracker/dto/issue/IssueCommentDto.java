package com.issuetracker.dto.issue;

import java.time.LocalDateTime;

import org.springframework.data.relational.core.mapping.Column;

import lombok.Getter;

@Getter
public class IssueCommentDto {
    @Column("commentId")
    private long commentId;
    @Column("userId")
    private long userId;
    @Column("userName")
    private String userName;
    private String profileUrl;
    private String content;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
