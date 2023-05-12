package com.issuetracker.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class FilterLabelDto {
    private int labelId;
    private String labelName;
    private String backgroundColor;
    private String fontColor;
    private String description;
}
