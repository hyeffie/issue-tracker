package com.issuetracker.dto.issueList;

import java.time.LocalDateTime;
import java.util.List;

import com.issuetracker.dto.issue.IssueLabelDto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class IssueDto {
    private long issueId;
    private String title;
    private String content;
    private String userName;
    private String profileUrl;
    private boolean isOpen;
    private LocalDateTime createdAt;
    private LocalDateTime closedAt;
    private String milestoneName;
    private List<IssueLabelDto> labelList;
}
