package com.issuetracker.repository;

import java.util.List;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import com.issuetracker.dto.FilterLabelDto;
import com.issuetracker.dto.FilterMilestoneDto;
import com.issuetracker.dto.FilterUserDto;
import com.issuetracker.dto.IssueDao;

public interface LabelRepository extends CrudRepository<IssueDao, Long> {
    @Query("SELECT i.id AS issueId, i.title AS title, i.content AS content, u.login_id AS userName,\n"
            + "u.profile_url AS profileUrl, i.opened AS opened, i.created_at AS createdAt, i.closed_at AS closedAt\n"
            + ", m.name AS milestoneName, l.id AS labelId, l.name AS labelName, l.background_color AS backgroundColor, l.font_color AS fontColor\n"
            + "FROM issue i\n"
            + "JOIN issue_label il ON i.id = il.issue_id\n"
            + "JOIN label l ON l.id = il.label_id\n"
            + "JOIN user u ON u.id =  i.user_id\n"
            + "JOIN milestone m ON m.id = i.milestone_id\n"
            + "WHERE i.deleted_at IS NULL;")
    List<IssueDao> getIssues();

    @Query("SELECT id, name, background_color, font_color, description FROM label;")
    List<FilterLabelDto> getFilterLabelList();
    @Query("SELECT id, login_id, profile_url FROM user")
    List<FilterUserDto> getFilterUserList();
    @Query("SELECT id, name, description FROM milestone")
    List<FilterMilestoneDto> getFilterMilestoneList();

}
