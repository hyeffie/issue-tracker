package com.issuetracker.domain;

import java.time.LocalDateTime;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@Table("milestone")
public class Milestone {
    @Id
    private Integer id;
    private String name;
    private String description;
    private LocalDateTime completedAt;
    private boolean opened;
    private boolean deleted;

    public static Milestone ofCreated(String name, String description, LocalDateTime completedAt) {
        return new MilestoneBuilder()
                .name(name)
                .description(description)
                .completedAt(completedAt)
                .opened(true)
                .deleted(false)
                .build();
    }

    public static Milestone ofUpdated(Integer id, String name, String description,
            LocalDateTime completedAt, boolean isOpen) {
        return new MilestoneBuilder()
                .id(id)
                .name(name)
                .description(description)
                .completedAt(completedAt)
                .opened(isOpen)
                .deleted(false)
                .build();
    }

    public static Milestone ofDeleted(Integer id, String name, String description, LocalDateTime completedAt,
            boolean opened) {
        return new MilestoneBuilder()
                .id(id)
                .name(name)
                .description(description)
                .completedAt(completedAt)
                .opened(opened)
                .deleted(true)
                .build();
    }
}

