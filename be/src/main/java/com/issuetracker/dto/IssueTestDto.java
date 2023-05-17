package com.issuetracker.dto;

import java.time.LocalDateTime;
import java.util.Set;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.MappedCollection;
import org.springframework.data.relational.core.mapping.Table;

import com.issuetracker.domain.Label;
import com.issuetracker.domain.Milestone;
import com.issuetracker.domain.User;

import lombok.Data;

@Data
@Table("issue")
public class IssueTestDto {
    @Column("issueId")
    private Long id;
    @Column("userName")
    private String userId;
    @Column("title")
    private String title;
    @Column("content")
    private String content;
    @Column("isOpen")
    private Boolean opened;
    @Column("createdAt")
    private LocalDateTime createdAt;
    @Column("closedAt")
    private LocalDateTime closedAt;


    // @MappedCollection(idColumn = "issueId", keyColumn = "labelId")
    // private Set<LabelTestDto> labelList;

    // @MappedCollection(idColumn = "id", keyColumn = "id")
    // private Set<User> userList;
}

