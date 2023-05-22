package com.issuetracker.dto.issue;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class IssueLabelDto {
    private int labelId;
    private String labelName;
    private String backgroundColor;
    private String fontColor;
}
