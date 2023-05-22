package com.issuetracker.dto.issueList;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class FilterLabelDto {
    private int labelId;
    private String labelName;
    private String backgroundColor;
    private String fontColor;
    private String description;
}

