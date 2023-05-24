package com.issuetracker.repository;

import com.issuetracker.domain.Assignee;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface AssigneeRepository extends CrudRepository<Assignee, Long> {
    @Query("SELECT id FROM assignee WHERE issue_id = :issueId")
    public List<Long> findByIssueId(long issueId);

}
