package com.issuetracker.dto.issue;

import java.time.LocalDateTime;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class IssueCommentDto {
    private long commentId;
    private long userId;
    private String userName;
    private String profileUrl;
    private String content;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
