package com.issuetracker.dto.label;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LabelDto {
    private int labelId;
    private String labelName;
    private String backgroundColor;
    private String fontColor;
    private String description;
}
