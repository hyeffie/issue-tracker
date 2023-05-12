package com.issuetracker.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class FilterUserDto {
    private int userId;
    private String userName;
    private String profileUrl;
}
