package com.issuetracker.dto.label;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.relational.core.mapping.Column;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class LabelDto {
    private Integer labelId;
    private String labelName;
    private String backgroundColor;
    private String fontColor;
    private String description;
}
