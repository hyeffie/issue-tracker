package com.issuetracker.dto.issueList;

import org.springframework.data.relational.core.mapping.Column;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class FilterUserDto {
    @Column("id")
    private int userId;
    @Column("login_id")
    private String userName;
    @Column("profile_url")
    private String profileUrl;
}
