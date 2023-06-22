package com.issuetracker.dto.issue;

import java.util.List;

import com.issuetracker.domain.User;
import com.issuetracker.dto.issueList.FilterLabelDto;
import com.issuetracker.dto.issueList.FilterMilestoneDto;
import com.issuetracker.dto.issueList.FilterUserDto;

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
    private IssueMilestone attachedMilestone;
    private List<IssueLabelDto> attachedLabelList;
    private List<User> attachedAssigneeList;
    private List<IssueCommentDto> commentList;
    private List<FilterUserDto> userList;
    private List<FilterLabelDto> labelList;
    private List<FilterMilestoneDto> milestoneList;

}
