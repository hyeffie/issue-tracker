package com.issuetracker.repository;

import java.util.List;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import com.issuetracker.domain.IssueLabel;
import com.issuetracker.domain.IssueListPage;
import com.issuetracker.domain.Label;
import com.issuetracker.domain.Milestone;
import com.issuetracker.domain.User;

public interface IssueLabelRepository extends CrudRepository<IssueLabel, Long> {

}
