package com.issuetracker.dto.issue;

import java.time.LocalDateTime;

import lombok.Getter;

@Getter
public class IssueDetailDto {
    private int issueId;
    private String title;
    private String content;
    private String userName;
    private String profileUrl;
    private boolean isOpen;
    private LocalDateTime createdAt;
    private LocalDateTime closedAt;
}
