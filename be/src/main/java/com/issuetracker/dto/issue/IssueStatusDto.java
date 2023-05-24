package com.issuetracker.dto.issue;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class IssueStatusDto {
    private long issueId;
    private Boolean isOpen;
}
