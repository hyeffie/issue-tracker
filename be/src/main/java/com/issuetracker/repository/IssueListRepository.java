package com.issuetracker.repository;

import java.util.List;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import com.issuetracker.dto.issueList.FilterLabelDto;
import com.issuetracker.dto.issueList.FilterMilestoneDto;
import com.issuetracker.dto.issueList.FilterUserDto;
import com.issuetracker.dto.issueList.IssueDao;

public interface IssueListRepository extends CrudRepository<IssueDao, Long> {
    /**
     * issue 각각에 달린 마일스톤, 라벨 목록, 유저 이름을 함께 조회해야하므로 Join하여 가져옵니다. 이 때, 열린 이슈만 조회하는데 현재는 열린 이슈만 조회되도록 작성되어있습니다.
     * @param isOpen
     * @return
     */
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

    /**
     * 라벨 필터에 사용할 전체 라벨의 목록을 조회합니다.
     */
    @Query("SELECT id, name, background_color, font_color, description FROM label WHERE deleted IS FALSE;")
    List<FilterLabelDto> getFilterLabelList();
    /**
     * 유저 필터에 사용할 전체 유저의 목록을 조회합니다.
     */
    @Query("SELECT id, login_id, profile_url FROM user")
    List<FilterUserDto> getFilterUserList();
    /**
     * 마일스톤 필터에 사용할 전체 마일스톤의 목록을 조회합니다.
     */
    @Query("SELECT id, name, description FROM milestone WHERE deleted IS FALSE")
    List<FilterMilestoneDto> getFilterMilestoneList();

    /**
     * 닫혀 있는 이슈의 총 개수를 조회합니다.
     */
    @Query("SELECT count(id) FROM issue WHERE deleted_at IS NULL AND opened = 0")
    Long getTotalClosedIssueCount();

}
