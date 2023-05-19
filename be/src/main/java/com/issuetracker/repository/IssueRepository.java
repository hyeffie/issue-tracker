package com.issuetracker.repository;

import com.issuetracker.dto.issue.*;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface IssueRepository extends CrudRepository<AssigneeDto, Long> {

    /**
     * issueId를 받아서 해당 이슈와 작성자의 정보를 가져오는 쿼리
     * @param issueId
     * @return
     */
    @Query("SELECT i.id, title, content, u.login_id, u.profile_url, i.opened, i.created_at, i.closed_at\n" +
            "FROM issue i\n" +
            "JOIN user u ON u.id = i.user_id\n" +
            "WHERE i.id = :issueId AND i.deleted_at IS NULL;")
    IssueDetailDto findIssueByIssueId(Long issueId);

    /**
     * issueId를 받아서 해당 issue에 달려있는 label에 대한 데이터를 가져오는 쿼리
     * @param issueId
     * @return
     */
    @Query("SELECT l.id, l.name, l.background_color, l.font_color\n" +
            "FROM issue i\n" +
            "JOIN issue_label il ON i.id = il.issue_id\n" +
            "JOIN label l ON il.label_id = l.id\n" +
            "WHERE i.id = :issueId AND l.deleted IS FALSE AND i.deleted_at IS NULL;")
    List<IssueLabelDto> findLabelListByIssueId(Long issueId);

    /**
     * issueId를 받아서 해당 이슈에 할당된 담당자의 데이터를 가져오는 쿼리
     * @param issueId
     * @return
     */
    @Query("SELECT u.id, u.login_id, u.profile_url\n" +
            "FROM assignee a\n" +
            "JOIN user u ON u.id = a.user_id\n" +
            "WHERE a.issue_id = :issueId;")
    List<AssigneeDto> findAssigneeListByIssueId(Long issueId);

    /**
     * issueId를 받아서 해당 이슈에 달려있는 댓글 목록의 데이터를 가져오는 쿼리
     * @param issueId
     * @return
     */
    @Query("SELECT c.id AS commentId, u.id AS userId, u.login_id, u.profile_url, c.content, c.created_at, c.updated_at\n" +
            "FROM comment c\n" +
            "JOIN user u ON c.user_id = u.id\n" +
            "WHERE c.issue_id = :issueId AND c.deleted_at IS NULL;")
    List<IssueCommentDto> findCommentListByIssueId(Long issueId);

    /**
     * issueId를 받아서 해당 이슈가 할당받은 milestone 데이터와 그 milestone의 진행 정도를 표현하기 위한 데이터를 가져오는 쿼리
     * @param issueId
     * @return
     */
    @Query(value = "SELECT m.id, m.name, COUNT(i.id) AS countAllIssues, SUM(i.opened IS FALSE) AS countAllClosedIssues\n" +
            "FROM milestone m\n" +
            "LEFT JOIN issue i ON m.id = i.milestone_id\n" +
            "WHERE m.id IN (SELECT DISTINCT milestone_id FROM issue WHERE id = :issueId AND i.deleted_at IS NULL)\n" +
            "GROUP BY m.id;")
    IssueMilestoneDto findMilestoneByIssueId(Long issueId);
}
