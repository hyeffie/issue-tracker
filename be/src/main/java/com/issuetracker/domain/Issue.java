package com.issuetracker.domain;

import java.time.LocalDateTime;
import java.util.Set;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.MappedCollection;
import org.springframework.data.relational.core.mapping.Table;

import lombok.Data;

@Data
@Table("issue")
public class Issue {
    @Id
    private Long id;
    @Column("user_id")
    private String userId;
    private Milestone milestone;
    private String title;
    private String content;
    private Boolean opened;
    private LocalDateTime createdAt;
    private LocalDateTime closedAt;
    private LocalDateTime deletedAt;
    @MappedCollection(idColumn = "id", keyColumn = "id")
    private Set<Label> labelList;

    @MappedCollection(idColumn = "id", keyColumn = "id")
    private Set<User> userList;
}

