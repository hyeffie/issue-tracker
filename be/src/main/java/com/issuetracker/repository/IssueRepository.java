package com.issuetracker.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jdbc.repository.query.Modifying;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import com.issuetracker.domain.Issue;
import com.issuetracker.domain.User;

public interface IssueRepository extends CrudRepository<Issue, Long> {

    /**
     * issueId를 받아서 해당 이슈와 작성자의 정보를 가져오는 쿼리
     * @param issueId
     * @return
     */
    @Query("SELECT id, user_id, milestone_id, title, content, opened, created_at, closed_at, deleted_at\n" +
            "FROM issue " +
            "WHERE id = :issueId AND deleted_at IS NULL;")
    Issue findIssueByIssueId(long issueId);



    /**
     * issueId를 받아서 해당 이슈에 할당된 담당자의 데이터를 가져오는 쿼리
     * @param issueId
     * @return
     */
    @Query("SELECT u.id, u.login_id, u.profile_url\n" +
            "FROM assignee a\n" +
            "JOIN user u ON u.id = a.user_id\n" +
            "WHERE a.issue_id = :issueId;")
    List<User> findAssigneeListByIssueId(long issueId);

    @Query("SELECT COUNT(i.id) FROM issue i\n" +
            "LEFT JOIN milestone m ON m.id = i.milestone_id\n"
            + "WHERE m.id = :milestoneId AND i.deleted_at IS NULL")
    long countAllIssuesOnMilestone(int milestoneId);

    @Query("SELECT COUNT(i.id) FROM issue i\n" +
            "LEFT JOIN milestone m ON m.id = i.milestone_id\n"
            + "WHERE m.id = :milestoneId AND i.deleted_at IS NULL AND i.opened=0")
    long countAllClosedIssuesOnMilestone(int milestoneId);

    /**
     * 열려있는 특정 이슈를 닫고 시간을 업데이트합니다.
     * @param issueId
     * @param now
     */
    @Modifying
    @Query("UPDATE issue SET opened=0, closed_at=:now WHERE id=:issueId AND opened=1")
    void closeIssueById(long issueId, LocalDateTime now);

    @Modifying
    @Query("UPDATE issue SET title=:title WHERE id=:issueId")
    void updateIssueTitle(long issueId, String title);

    @Modifying
    @Query("UPDATE issue SET content=:content WHERE id=:issueId")
    void updateIssueContent(long issueId, String content);

    @Modifying
    @Query("UPDATE issue SET milestone_id=:milestoneId WHERE id=:issueId")
    void updateIssueMilestone(long issueId, int milestoneId);

    /**
     * 닫혀있는 특정 이슈를 엽니다.
     * @param issueId
     */
    @Modifying
    @Query("UPDATE issue SET opened=1, closed_at=NULL WHERE id=:issueId AND opened=0")
    void openIssueById(long issueId);

    /**
     * 닫혀 있는 이슈의 총 개수를 조회합니다.
     */
    @Query("SELECT count(id) FROM issue WHERE deleted_at IS NULL AND opened IS FALSE")
    long getTotalClosedIssueCount();

    /**
     * 열려 있는 이슈의 총 개수를 조회합니다.
     */
    @Query("SELECT count(id) FROM issue WHERE deleted_at IS NULL AND opened IS TRUE")
    long getTotalOpendIssueCount();
}
