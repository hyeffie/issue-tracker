package com.issuetracker.dto.issue;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.relational.core.mapping.Column;

@Data
@AllArgsConstructor
public class IssueLabelDto {
    @Column("id")
    private Integer labelId;
    @Column("name")
    private String labelName;
    @Column("background_color")
    private String backgroundColor;
    @Column("font_color")
    private String fontColor;
}
