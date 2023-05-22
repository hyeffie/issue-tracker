package com.issuetracker.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@Table("milestone")
public class Milestone {
    @Id
    private int id;
    private String name;
    private String description;
    @Column("completedAt")
    private LocalDateTime completedAt;
    private boolean opened;
    private boolean deleted;
}

