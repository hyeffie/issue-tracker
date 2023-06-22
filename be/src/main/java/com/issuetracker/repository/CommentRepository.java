package com.issuetracker.repository;

import java.util.List;

import com.issuetracker.domain.Comment;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

public interface CommentRepository extends CrudRepository<Comment, Long> {

    /**
     * issueId를 받아서 해당 이슈에 달려있는 댓글 목록의 데이터를 가져오는 쿼리
     * @param issueId
     * @return
     */
    @Query("SELECT id, user_id, issue_id, content, created_at, updated_at\n" +
            "FROM comment\n" +
            "WHERE issue_id = :issueId AND deleted_at IS NULL")
    List<Comment> findCommentListByIssueId(long issueId);
    
}
