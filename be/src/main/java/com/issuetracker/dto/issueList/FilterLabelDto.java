package com.issuetracker.dto.issueList;

import org.springframework.data.relational.core.mapping.Column;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class FilterLabelDto {
    @Column("id")
    private int labelId;
    @Column("name")
    private String labelName;
    @Column("background_color")
    private String backgroundColor;
    @Column("font_color")
    private String fontColor;
    @Column("description")
    private String description;
}
