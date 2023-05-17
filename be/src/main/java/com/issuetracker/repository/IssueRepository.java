package com.issuetracker.repository;

import com.issuetracker.dto.issue.AssigneeDto;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface IssueRepository extends CrudRepository<AssigneeDto, Long> {

    @Query("SELECT u.id, u.login_id, u.profile_url\n" +
            "FROM issue_tracker.assignee a\n" +
            "JOIN issue_tracker.user u ON u.id = a.user_id\n" +
            "WHERE a.issue_id = :issueId;")
    List<AssigneeDto> findAssigneesByIssueId(Long issueId);
}
