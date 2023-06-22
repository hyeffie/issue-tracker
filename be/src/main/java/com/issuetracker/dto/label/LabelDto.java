package com.issuetracker.dto.label;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LabelDto {
    private int labelId;
    private String labelName;
    private String backgroundColor;
    private String fontColor;
    private String description;
}
