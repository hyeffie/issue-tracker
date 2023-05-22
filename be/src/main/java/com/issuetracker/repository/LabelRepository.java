package com.issuetracker.repository;

import com.issuetracker.domain.Label;
import com.issuetracker.dto.label.LabelDto;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface LabelRepository extends CrudRepository<Label, Long> {

    @Query("SELECT id, name, background_color, font_color, description, deleted\n" +
            "FROM label\n" +
            "WHERE deleted IS FALSE;")
    List<Label> findAllLabels();


}
