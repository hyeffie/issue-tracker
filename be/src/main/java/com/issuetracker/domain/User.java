package com.issuetracker.domain;

import java.util.Set;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.MappedCollection;
import org.springframework.data.relational.core.mapping.Table;

import lombok.Data;

@Data
@Table("user")
public class User {
    @Id
    private Integer id;
    @Column("login_id")
    private String name;
    private String password;
    @Column("profile_url")
    private String profileUrl;
    @MappedCollection(idColumn = "user_id", keyColumn = "issue_id")
    private Set<Issue> issueList;
}
