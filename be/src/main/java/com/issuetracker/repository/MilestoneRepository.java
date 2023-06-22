package com.issuetracker.repository;

import java.util.List;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import com.issuetracker.domain.Milestone;

public interface MilestoneRepository extends CrudRepository<Milestone, Long> {

    @Query("SELECT id, name, description, completed_at, opened, deleted\n" +
            "FROM milestone\n" +
            "WHERE deleted IS FALSE")
    List<Milestone> findAllMilestones();

    @Query("SELECT count(id) AS count\n" +
            "FROM issue\n" +
            "WHERE milestone_id = :milestoneId AND opened IS TRUE AND deleted_at IS NULL")
    long countOpenedIssuesByMilestoneId(int milestoneId);

    @Query("SELECT count(id) AS count\n" +
            "FROM issue\n" +
            "WHERE milestone_id = :milestoneId AND opened IS FALSE AND deleted_at IS NULL")
    long countClosedIssuesByMilestoneId(int milestoneId);

    @Query("SELECT count(id) AS count\n" +
            "FROM milestone\n" +
            "WHERE opened IS TRUE AND deleted IS FALSE")
    int countOpenedMilestones();

    @Query("SELECT count(id) AS count\n" +
            "FROM milestone\n" +
            "WHERE opened IS FALSE AND deleted IS FALSE")
    int countClosedMilestones();

    @Query("SELECT m.id, m.name, m.opened, m.deleted FROM issue i\n" +
            "LEFT JOIN milestone m ON m.id = i.milestone_id\n" +
            "WHERE i.id = :issueId")
    Milestone findMilestoneByIssueId(long issueId);

    @Query("SELECT count(m.id) FROM issue i\n" +
            "LEFT JOIN milestone m ON m.id = i.milestone_id\n" +
            "WHERE i.id = :issueId AND m.deleted IS FALSE")
    Integer isExistMilestoneByIssueId(long issueId);

    /**
     * 마일스톤 필터에 사용할 전체 마일스톤의 목록을 조회합니다.
     */
    @Query("SELECT id, name, description, opened, deleted FROM milestone WHERE deleted IS FALSE")
    List<Milestone> getFilterMilestoneList();

    @Query("SELECT count(id) FROM milestone WHERE deleted is FALSE")
    int countAllMilestones();

}
