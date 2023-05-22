package com.issuetracker.dto.label;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class LabelVo {
    private String labelName;
    private String backgroundColor;
    private String fontColor;
    private String description;
}
