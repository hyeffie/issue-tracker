package com.issuetracker.dto.issue;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AssigneeDto {
    private long id;
    private String userName;
    private String profileUrl;
}
