package com.issuetracker.dto.issueList;

import java.time.LocalDateTime;

import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import lombok.Data;

@Data
@Table("issue")
public class IssueDao {
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

