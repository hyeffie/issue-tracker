package com.issuetracker.repository;

import java.util.List;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import com.issuetracker.dto.issueList.FilterLabelDto;
import com.issuetracker.dto.issueList.FilterMilestoneDto;
import com.issuetracker.dto.issueList.FilterUserDto;
import com.issuetracker.dto.issueList.IssueDao;

public interface IssueListRepository extends CrudRepository<IssueDao, Long> {
    @Query("SELECT i.id AS issueId, i.title AS title, i.content AS content, u.login_id AS userName,\n"
            + "u.profile_url AS profileUrl, i.opened AS opened, i.created_at AS createdAt, i.closed_at AS closedAt\n"
            + ", m.name AS milestoneName, l.id AS labelId, l.name AS labelName, l.background_color AS backgroundColor, l.font_color AS fontColor\n"
            + "FROM issue i\n"
            + "LEFT OUTER JOIN issue_label il ON i.id = il.issue_id\n"
            + "LEFT OUTER JOIN (SELECT * from label WHERE deleted IS FALSE) l ON l.id = il.label_id\n"
            + "LEFT OUTER JOIN user u ON u.id =  i.user_id\n"
            + "LEFT OUTER JOIN (SELECT * from milestone WHERE deleted IS FALSE) m ON m.id = i.milestone_id\n"
            + "WHERE i.deleted_at IS NULL AND i.opened= :isOpen;")
    List<IssueDao> getIssues(Boolean isOpen);

    @Query("SELECT id, name, background_color, font_color, description FROM label WHERE deleted IS FALSE;")
    List<FilterLabelDto> getFilterLabelList();
    @Query("SELECT id, login_id, profile_url FROM user")
    List<FilterUserDto> getFilterUserList();
    @Query("SELECT id, name, description FROM milestone WHERE deleted IS FALSE")
    List<FilterMilestoneDto> getFilterMilestoneList();

    @Query("SELECT count(id) FROM issue WHERE deleted_at IS NULL AND opened = 0")
    Long getTotalClosedIssueCount();

}
