package com.issuetracker.repository;

import com.issuetracker.domain.Issue;
import com.issuetracker.domain.Label;
import com.issuetracker.dto.IssueLabelDto;
import com.issuetracker.dto.IssueTestDto;
import com.issuetracker.dto.MilestoneTestDto;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface LabelRepository extends CrudRepository<MilestoneTestDto, Integer> {

    @Query("SELECT l.id AS labelId, l.name AS labelName, l.background_color AS backgroundColor, l.font_color AS fontColor\n" +
            "FROM issue i\n" +
            "JOIN issue_label il ON i.id = il.issue_id\n" +
            "JOIN label l ON l.id = il.label_id;")
    List<IssueLabelDto> getLabels();

    @Query("SELECT i.id AS issueId, i.title AS title, i.content AS content, i.opened AS isOpen, i.created_at AS createdAt, i.closed_at AS closedAt, l.id AS labelId, l.name AS labelName, l.background_color AS backgroundColor, l.font_color AS fontColor, l.description AS description\n"
            + "FROM issue i\n"
            + "LEFT OUTER JOIN issue_label il ON i.id = il.issue_id LEFT JOIN label l ON il.label_id = l.id;")
    List<IssueTestDto> getAllIssues();

    @Query("SELECT i.id AS issueId, i.title AS title, i.content AS content, i.opened AS isOpen, i.created_at AS createdAt, i.closed_at AS closedAt, m.id AS milestoneId, m.name AS milestoneName, m.description AS mDescription, m.completed_at AS completedAt, m.opened AS mIsOpened, m.deleted AS mDeleted\n"
            + "FROM issue i\n"
            + "LEFT OUTER JOIN milestone m ON i.milestone_id = m.id;")
    List<MilestoneTestDto> getAllIssuesAndMilestone();

}
