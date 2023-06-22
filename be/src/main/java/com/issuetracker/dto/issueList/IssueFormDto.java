package com.issuetracker.dto.issueList;

import java.util.List;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder

public class IssueFormDto {
    private List<FilterUserDto> userList;
    private List<FilterLabelDto> labelList;
    private List<FilterMilestoneProgressDto> milestoneList;

}
