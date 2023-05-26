package com.issuetracker.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jdbc.repository.query.Modifying;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import com.issuetracker.domain.Issue;
import com.issuetracker.domain.Label;
import com.issuetracker.dto.issue.AssigneeDto;
import com.issuetracker.dto.issue.IssueCommentDto;
import com.issuetracker.dto.issue.IssueMilestone;

public interface IssueRepository extends CrudRepository<Issue, Long> {

    /**
     * issueId를 받아서 해당 이슈와 작성자의 정보를 가져오는 쿼리
     * @param issueId
     * @return
     */
    @Query("SELECT id, user_id, milestone_id, title, content, opened, created_at, closed_at, deleted_at\n"
            + "FROM issue WHERE id = :issueId AND deleted_at IS NULL;")
    Issue findIssueByIssueId(long issueId);

    /**
     * issueId를 받아서 해당 issue에 달려있는 label에 대한 데이터를 가져오는 쿼리
     * @param issueId
     * @return
     */
    @Query("SELECT l.id, l.name, l.background_color, l.font_color, l.description, l.deleted\n"
            + "FROM issue i\n"
            + "JOIN issue_label il ON i.id = il.issue_id\n"
            + "JOIN label l ON il.label_id = l.id\n"
            + "WHERE i.id =:issueId AND l.deleted IS FALSE AND i.deleted_at IS NULL")
    List<Label> findLabelListByIssueId(long issueId);

    /**
     * issueId를 받아서 해당 이슈에 할당된 담당자의 데이터를 가져오는 쿼리
     * @param issueId
     * @return
     */
    @Query("SELECT u.id, u.login_id, u.profile_url\n" +
            "FROM assignee a\n" +
            "JOIN user u ON u.id = a.user_id\n" +
            "WHERE a.issue_id = :issueId;")
    List<AssigneeDto> findAssigneeListByIssueId(long issueId);

    /**
     * issueId를 받아서 해당 이슈에 달려있는 댓글 목록의 데이터를 가져오는 쿼리
     * @param issueId
     * @return
     */
    @Query("SELECT c.id AS commentId, u.id AS userId, u.login_id AS userName, u.profile_url, c.content, c.created_at, c.updated_at\n"
            +
            "FROM comment c\n" +
            "JOIN user u ON c.user_id = u.id\n" +
            "WHERE c.issue_id = :issueId AND c.deleted_at IS NULL;")
    List<IssueCommentDto> findCommentListByIssueId(long issueId);

    /**
     * issueId를 받아서 해당 이슈가 할당받은 milestone 데이터와 그 milestone의 진행 정도를 표현하기 위한 데이터를 가져오는 쿼리
     * @param issueId
     * @return
     */
    @Query(value =
            "SELECT m.id, m.name, COUNT(i.id) AS countAllIssues, SUM(i.opened IS FALSE) AS countAllClosedIssues\n" +
                    "FROM milestone m\n" +
                    "LEFT JOIN issue i ON m.id = i.milestone_id\n" +
                    "WHERE m.id IN (SELECT DISTINCT milestone_id FROM issue WHERE id = :issueId AND i.deleted_at IS NULL)\n"
                    +
                    "GROUP BY m.id;")
    IssueMilestone findMilestoneByIssueId(long issueId);

    /**
     * 열려있는 특정 이슈를 닫고 시간을 업데이트합니다.
     * @param issueId
     * @param now
     */
    @Modifying
    @Query(value = "UPDATE issue SET opened=0, closed_at=:now WHERE id=:issueId AND opened=1")
    void closeIssueById(long issueId, LocalDateTime now);

    /**
     * 닫혀있는 특정 이슈를 엽니다.
     * @param issueId
     */
    @Modifying
    @Query(value = "UPDATE issue SET opened=1 WHERE id=:issueId AND opened=0")
    void openIssueById(long issueId);
}
