package com.issuetracker.repository;

import com.issuetracker.dto.issue.IssueLabelDto;
import com.issuetracker.dto.issue.AssigneeDto;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface IssueRepository extends CrudRepository<AssigneeDto, Long> {

    @Query("SELECT l.id, l.name, l.background_color, l.font_color\n" +
            "FROM issue i\n" +
            "JOIN issue_label il ON i.id = il.issue_id\n" +
            "JOIN label l ON il.label_id = l.id\n" +
            "WHERE i.id = :issueId AND l.deleted IS FALSE AND i.deleted_at IS NULL;")
    List<IssueLabelDto> findLabelListByIssueId(Long issueId);

    @Query("SELECT u.id, u.login_id, u.profile_url\n" +
            "FROM assignee a\n" +
            "JOIN user u ON u.id = a.user_id\n" +
            "WHERE a.issue_id = :issueId;")
    List<AssigneeDto> findAssigneesByIssueId(Long issueId);
}
