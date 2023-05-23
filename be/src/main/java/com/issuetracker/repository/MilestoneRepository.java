package com.issuetracker.repository;

import com.issuetracker.domain.Milestone;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface MilestoneRepository extends CrudRepository<Milestone, Long> {

    @Query("SELECT id, name, description, completed_at, opened, deleted\n" +
            "FROM milestone\n" +
            "WHERE opened IS TRUE AND deleted IS FALSE")
    List<Milestone> findAllMilestones();

    @Query("SELECT count(id) AS count\n" +
            "FROM issue\n" +
            "WHERE milestone_id = :milestoneId AND opened IS TRUE AND deleted_at IS NULL;")
    long countOpenedIssuesByMilestoneId(int milestoneId);

    @Query("SELECT count(id) AS count\n" +
            "FROM issue\n" +
            "WHERE milestone_id = :milestoneId AND opened IS FALSE AND deleted_at IS NULL;")
    long countClosedIssuesByMilestoneId(int milestoneId);

    @Query("SELECT count(id) AS count\n" +
            "FROM milestone\n" +
            "WHERE opened IS TRUE AND deleted IS FALSE;")
    int countOpenedMilestones();

    @Query("SELECT count(id) AS count\n" +
            "FROM milestone\n" +
            "WHERE opened IS FALSE AND deleted IS FALSE;")
    int countClosedMilestones();
}
