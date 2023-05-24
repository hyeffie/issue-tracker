package com.issuetracker.dto.issue;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
public class IssueLabelDto {
    private int labelId;
    private String labelName;
    private String backgroundColor;
    private String fontColor;
}
