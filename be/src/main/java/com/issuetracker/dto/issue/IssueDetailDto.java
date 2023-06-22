package com.issuetracker.dto.issue;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class IssueDetailDto {
    private long issueId;
    private String title;
    private String content;
    private String userName;
    private String profileUrl;
    private boolean isOpen;
    private LocalDateTime createdAt;
    private LocalDateTime closedAt;
}
