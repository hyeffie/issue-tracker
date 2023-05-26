package com.issuetracker.repository;

import java.util.List;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import com.issuetracker.domain.IssueLabel;

public interface IssueLabelRepository extends CrudRepository<IssueLabel, Long> {
    @Query("SELECT id FROM issue_label WHERE issue_id = :issueId")
    public List<Long> findByIssueId(long issueId);
}
