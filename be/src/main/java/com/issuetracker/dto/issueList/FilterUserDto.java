package com.issuetracker.dto.issueList;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class FilterUserDto {
    private int userId;
    private String userName;
    private String profileUrl;
}
