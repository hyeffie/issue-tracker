package com.issuetracker.dto.issueList;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class FilterUserDto {
    private int userId;
    private String userName;
    private String profileUrl;
}
