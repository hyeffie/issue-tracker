package com.issuetracker.dto.issue;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class IssueDetailPageDto {
    private IssueDetailDto issue;
    private IssueMilestoneDto milestone;
    private List<IssueLabelDto> labelList;
    private List<AssigneeDto> assigneeList;
    private List<IssueCommentDto> commentList;
}
