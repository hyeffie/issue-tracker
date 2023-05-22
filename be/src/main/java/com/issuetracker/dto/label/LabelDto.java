package com.issuetracker.dto.label;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.relational.core.mapping.Column;

@Getter
@Setter
@AllArgsConstructor
public class LabelDto {

    public LabelDto(String labelName, String backgroundColor, String fontColor, String description) {
        this.labelName = labelName;
        this.backgroundColor = backgroundColor;
        this.fontColor = fontColor;
        this.description = description;
    }

    @Column("id")
    private Integer labelId;
    @Column("name")
    private String labelName;
    @Column("background_color")
    private String backgroundColor;
    @Column("font_color")
    private String fontColor;
    @Column("description")
    private String description;
}
