package com.issuetracker.dto.issue;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.data.relational.core.mapping.Column;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Optional;

@Data
@AllArgsConstructor
public class IssueCommentDto {
    @Column("commentId")
    private Long commentId;
    @Column("userId")
    private Long userId;
    @Column("login_id")
    private String userName;
    @Column("profile_url")
    private String profileUrl;
    @Column("content")
    private String content;
    @Column("created_at")
    private LocalDateTime createdAt;
    @Column("updated_at")
    private LocalDateTime updatedAt;

    public String getCreatedAt() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return createdAt.format(formatter);
    }

    public String getUpdatedAt() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return Optional.ofNullable(updatedAt)
                .map(formatter::format)
                .orElse(null);
    }
}
