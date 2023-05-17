package com.issuetracker.domain;

import java.time.LocalDateTime;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import lombok.Data;

@Data
@Table("milestone")
public class Milestone {
    @Id
    private Integer id;
    private String name;
    private String description;
    @Column("completed_at")
    private LocalDateTime completedAt;
    private Boolean opened;
    @Column("deleted")
    private Boolean deleted;
}


