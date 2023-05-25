package com.issuetracker.dto.issue;

import org.springframework.data.relational.core.mapping.Column;

import lombok.Getter;

@Getter
public class AssigneeDto {
    private long id;
    @Column("login_id")
    private String userName;
    private String profileUrl;
}
