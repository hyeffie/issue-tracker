package com.issuetracker.repository;

import com.issuetracker.domain.Label;
import com.issuetracker.dto.issue.IssueLabelDto;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface LabelRepository extends CrudRepository<Label, Integer> {

    @Query("SELECT l.id AS labelId, l.name AS labelName, l.background_color AS backgroundColor, l.font_color AS fontColor\n" +
            "FROM issue i\n" +
            "JOIN issue_label il ON i.id = il.issue_id\n" +
            "JOIN label l ON l.id = il.label_id;")
    List<IssueLabelDto> getLabels();

}
