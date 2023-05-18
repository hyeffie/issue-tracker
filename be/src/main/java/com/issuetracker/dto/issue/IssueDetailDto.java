package com.issuetracker.dto.issue;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Optional;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.data.relational.core.mapping.Column;

@Data
@AllArgsConstructor
public class IssueDetailDto {
    @Column("id")
    private Integer issueId;
    @Column("title")
    private String title;
    @Column("content")
    private String content;
    @Column("login_id")
    private String userName;
    @Column("profile_url")
    private String profileUrl;
    @Column("opened")
    private boolean isOpen;
    @Column("created_at")
    private LocalDateTime createdAt;
    @Column("closed_at")
    private LocalDateTime closedAt;

    public String getCreatedAt() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return createdAt.format(formatter);
    }

    public String getClosedAt() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return Optional.ofNullable(closedAt)
                .map(formatter::format)
                .orElse(null);
    }
}
