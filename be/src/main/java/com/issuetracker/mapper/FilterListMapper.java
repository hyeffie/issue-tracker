package com.issuetracker.mapper;

import java.util.List;
import java.util.stream.Collectors;

import com.issuetracker.domain.Label;
import com.issuetracker.domain.Milestone;
import com.issuetracker.domain.User;
import com.issuetracker.dto.issueList.FilterLabelDto;
import com.issuetracker.dto.issueList.FilterMilestoneDto;
import com.issuetracker.dto.issueList.FilterUserDto;

public class FilterListMapper {

    public static List<FilterUserDto> getFilterUserDtos(List<User> userList) {
        return userList.stream()
                .map(user -> new FilterUserDto(user.getId(), user.getLoginId(), user.getProfileUrl()))
                .collect(Collectors.toUnmodifiableList());
    }

    public static List<FilterMilestoneDto> getFilterMilestoneDtos(List<Milestone> milestoneList) {
        return milestoneList.stream()
                .map(milestone -> new FilterMilestoneDto(milestone.getId(), milestone.getName(),
                        milestone.getDescription()))
                .collect(Collectors.toUnmodifiableList());
    }

    public static List<FilterLabelDto> getFilterLabelDtos(List<Label> labelList) {
        return labelList.stream()
                .map(label -> new FilterLabelDto(label.getId(), label.getName(), label.getBackgroundColor(),
                        label.getFontColor(), label.getDescription()))
                .collect(Collectors.toUnmodifiableList());
    }
}
