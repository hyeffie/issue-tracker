package com.issuetracker.repository;

import com.issuetracker.domain.Label;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface LabelRepository extends CrudRepository<Label, Long> {

    @Query("SELECT id, name, background_color, font_color, description, deleted\n" +
            "FROM label\n" +
            "WHERE deleted IS FALSE;")
    List<Label> findAllLabels();

    /**
     * issueId를 받아서 해당 issue에 달려있는 label에 대한 데이터를 가져오는 쿼리
     * @param issueId
     * @return
     */
    @Query("SELECT l.id, l.name, l.background_color, l.font_color, l.description, l.deleted\n"
            + "FROM issue i\n"
            + "JOIN issue_label il ON i.id = il.issue_id\n"
            + "JOIN label l ON il.label_id = l.id\n"
            + "WHERE i.id =:issueId AND l.deleted IS FALSE AND i.deleted_at IS NULL")
    List<Label> findLabelListByIssueId(long issueId);

    /**
     * 라벨 필터에 사용할 전체 라벨의 목록을 조회합니다.
     */
    @Query("SELECT id, name, background_color, font_color, description, deleted FROM label WHERE deleted IS FALSE;")
    List<Label> getFilterLabelList();

    @Query("SELECT count(id) FROM label WHERE deleted is FALSE")
    int countAllLabels();

}
