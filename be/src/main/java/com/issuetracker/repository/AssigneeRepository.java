package com.issuetracker.repository;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.repository.CrudRepository;

import com.issuetracker.domain.Assignee;
import com.issuetracker.domain.IssueLabel;

public interface AssigneeRepository extends CrudRepository<Assignee, Long> {


}
