package com.issuetracker.domain;

import java.time.LocalDateTime;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

import com.issuetracker.dto.comment.CommentPostDto;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@Table("comment")
public class Comment {
    @Id
    private Long id;
    private Long userId;
    private Long issueId;
    private String content;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private LocalDateTime deletedAt;

    public static Comment ofCreated(CommentPostDto commentPostDto, long issueId) {
        return new CommentBuilder()
                .userId(commentPostDto.getUserId())
                .issueId(issueId)
                .content(commentPostDto.getContent())
                .createdAt(LocalDateTime.now())
                .build();
    }

    public static Comment ofUpdated(CommentPostDto commentPostDto, Comment unmodifiedComment, long id,
            long issueId) {
        return new CommentBuilder()
                .id(id)
                .userId(unmodifiedComment.getUserId())
                .issueId(issueId)
                .content(commentPostDto.getContent())
                .createdAt(unmodifiedComment.getCreatedAt())
                .updatedAt(LocalDateTime.now())
                .build();
    }

    public static Comment ofDeleted(Comment comment) {
        return new CommentBuilder()
                .id(comment.getId())
                .userId(comment.getUserId())
                .issueId(comment.getIssueId())
                .content(comment.getContent())
                .createdAt(comment.getCreatedAt())
                .updatedAt(comment.getUpdatedAt())
                .deletedAt(LocalDateTime.now())
                .build();
    }
}
