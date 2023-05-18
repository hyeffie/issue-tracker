package com.issuetracker.dto.issue;

import com.issuetracker.domain.Milestone;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class IssueDetailDto {

    private List<AssigneeDto> assigneeList;
    private List<IssueLabelDto> labelList;
    private List<IssueCommentDto> commentList;
    private IssueMilestoneDto milestone;
}
