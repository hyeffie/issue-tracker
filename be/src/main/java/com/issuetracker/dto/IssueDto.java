package com.issuetracker.dto;

import java.util.List;

import com.issuetracker.dto.issue.IssueLabelDto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class IssueDto {
    private int issueId;
    private String title;
    private String content;
    private String userName;
    private String profileUrl;
    private boolean isOpen;
    private String createdAt;
    private String closedAt;
    private String milestoneName;
    private List<IssueLabelDto> labelList;
}
