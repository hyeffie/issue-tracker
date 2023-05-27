package com.issuetracker.dto.issue;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
public class UserDto {
    private long userId;
    private String loginId;
    private String profileUrl;
}

