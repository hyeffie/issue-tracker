package com.issuetracker.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Table("user")
public class User {
    @Id
    private int id;
    @Column("login_id")
    private String loginId;
    @Column("profile_url")
    private String profileUrl;
}

