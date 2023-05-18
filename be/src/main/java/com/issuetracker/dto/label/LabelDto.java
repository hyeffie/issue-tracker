package com.issuetracker.dto.label;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.relational.core.mapping.Column;

@Getter
@Setter
@AllArgsConstructor
public class LabelDto {
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
