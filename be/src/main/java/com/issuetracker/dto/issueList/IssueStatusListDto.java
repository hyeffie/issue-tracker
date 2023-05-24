package com.issuetracker.dto.issueList;

import com.issuetracker.dto.issue.IssueStatusDto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class IssueStatusListDto {
    private List<IssueStatusDto> issues;
}
