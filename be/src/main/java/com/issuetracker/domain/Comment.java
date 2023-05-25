package com.issuetracker.domain;

import com.issuetracker.dto.comment.CommentPostDto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import java.time.LocalDateTime;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Table("comment")
public class Comment {
    @Id
    private Long id;
    @Column("user_id")
    private Long userId;
    @Column("issue_id")
    private Long issueId;
    private String content;
    @Column("created_at")
    private LocalDateTime createdAt;
    @Column("updated_at")
    private LocalDateTime updatedAt;
    @Column("deleted_at")
    private LocalDateTime deletedAt;

    public static Comment createComment(CommentPostDto commentPostDto, long issueId) {
        return new Comment(null, commentPostDto.getUserId(), issueId, commentPostDto.getContent(), LocalDateTime.now(), null, null);
    }

    public static Comment updateComment(CommentPostDto commentPostDto, Comment unmodifiedComment, long id, long issueId) {
        return new Comment(id, unmodifiedComment.getUserId(), issueId, commentPostDto.getContent(), unmodifiedComment.getCreatedAt(), LocalDateTime.now(), null);
    }

    public static Comment deleteComment(Comment comment) {
        return new Comment(comment.getId(), comment.getUserId(), comment.getIssueId(), comment.getContent(), comment.getCreatedAt(), comment.getUpdatedAt(), LocalDateTime.now());
    }
}
