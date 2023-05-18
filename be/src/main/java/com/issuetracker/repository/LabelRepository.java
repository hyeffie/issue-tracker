package com.issuetracker.repository;

import com.issuetracker.dto.label.LabelDto;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface LabelRepository extends CrudRepository<LabelDto, Long> {

    @Query("SELECT id, name, background_color, font_color, description\n" +
            "FROM label\n" +
            "WHERE deleted IS FALSE;")
    List<LabelDto> findAllLabels();
}
