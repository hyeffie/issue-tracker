package com.issuetracker.domain;

import java.time.LocalDateTime;

import org.springframework.data.relational.core.mapping.Column;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class IssueListPage {
    @Column("issueId")
    private Long id;
    private String title;
    private String content;
    @Column("userName")
    private String userName;
    @Column("profileUrl")
    private String profileUrl;
    @Column("opened")
    private Boolean opened;
    @Column("createdAt")
    private LocalDateTime createdAt;
    @Column("closedAt")
    private LocalDateTime closedAt;
    @Column("milestoneName")
    private String milestoneName;
    @Column("labelId")
    private Integer labelId;
    @Column("labelName")
    private String labelName;
    @Column("backgroundColor")
    private String backgroundColor;
    @Column("fontColor")
    private String fontColor;
}

