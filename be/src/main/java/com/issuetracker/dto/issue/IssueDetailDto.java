package com.issuetracker.dto.issue;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class IssueDetailDto {
    private IssueDto issue;
    private IssueMilestoneDto milestone;
    private List<IssueLabelDto> labelList;
    private List<AssigneeDto> assigneeList;
    private List<IssueCommentDto> commentList;
}
