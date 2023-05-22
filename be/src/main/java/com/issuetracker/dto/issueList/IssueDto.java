package com.issuetracker.dto.issueList;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

import com.issuetracker.dto.issue.IssueLabelDto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class IssueDto {
    private Long issueId;
    private String title;
    private String content;
    private String userName;
    private String profileUrl;
    private Boolean isOpen;
    private LocalDateTime createdAt;
    private LocalDateTime closedAt;
    private String milestoneName;
    private List<IssueLabelDto> labelList;

    public String getCreatedAt() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return Optional.ofNullable(createdAt)
                .map(formatter::format)
                .orElse(null);
    }

    public String getClosedAt() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return Optional.ofNullable(closedAt)
                .map(formatter::format)
                .orElse(null);
    }
}
