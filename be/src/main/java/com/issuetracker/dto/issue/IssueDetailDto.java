package com.issuetracker.dto.issue;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
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
