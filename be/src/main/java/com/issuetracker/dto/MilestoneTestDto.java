package com.issuetracker.dto;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.MappedCollection;
import org.springframework.data.relational.core.mapping.Table;

import lombok.Data;

@Data
@Table("milestone")
public class MilestoneTestDto {
    @Column("milestoneId")
    private Integer id;
    @Column("milestoneName")
    private String name;
    @Column("mDescription")
    private String description;
    @Column("completedAt")
    private LocalDateTime completedAt;
    @Column("mIsOpened")
    private Boolean opened;
    @Column("mDeleted")
    private Boolean deleted;

    @MappedCollection(idColumn = "issueId", keyColumn = "milestoneId")
    private Set<IssueTestDto> issueTestDtos;
}
