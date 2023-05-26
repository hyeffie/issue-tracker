package com.issuetracker.repository;

import java.util.List;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import com.issuetracker.domain.IssueListPage;
import com.issuetracker.domain.Label;
import com.issuetracker.domain.Milestone;
import com.issuetracker.domain.User;

public interface IssueListRepository extends CrudRepository<IssueListPage, Long> {

    @Query("SELECT i.id AS issueId, i.title AS title, i.content AS content, u.login_id AS userName,\n" +
            "u.profile_url AS profileUrl, i.opened AS opened, i.created_at AS createdAt, i.closed_at AS closedAt\n" +
            ", m.name AS milestoneName, l.id AS labelId, l.name AS labelName, l.background_color AS backgroundColor, l.font_color AS fontColor\n" +
            "FROM issue i\n" +
            "LEFT OUTER JOIN issue_label il ON i.id = il.issue_id\n" +
            "LEFT OUTER JOIN label l ON l.id = il.label_id\n" +
            "LEFT OUTER JOIN assignee a ON a.issue_id = i.id\n" +
            "JOIN user u ON u.id =  i.user_id\n" +
            "LEFT OUTER JOIN milestone m ON m.id = i.milestone_id\n" +
            "WHERE i.id = :id")
    List<IssueListPage> getIssues(long id);

    /**
     * 라벨 필터에 사용할 전체 라벨의 목록을 조회합니다.
     */
    @Query("SELECT id, name, background_color, font_color, description, deleted FROM label WHERE deleted IS FALSE;")
    List<Label> getFilterLabelList();

    /**
     * 유저 필터에 사용할 전체 유저의 목록을 조회합니다.
     */
    @Query("SELECT id, login_id, profile_url FROM user")
    List<User> getFilterUserList();

    /**
     * 마일스톤 필터에 사용할 전체 마일스톤의 목록을 조회합니다.
     */
    @Query("SELECT id, name, description FROM milestone WHERE deleted IS FALSE")
    List<Milestone> getFilterMilestoneList();

    /**
     * 닫혀 있는 이슈의 총 개수를 조회합니다.
     */
    @Query("SELECT count(id) FROM issue WHERE deleted_at IS NULL AND opened IS FALSE")
    long getTotalClosedIssueCount();

}
