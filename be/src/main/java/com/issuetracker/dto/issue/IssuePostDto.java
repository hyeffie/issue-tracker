package com.issuetracker.dto.issue;

import java.util.List;

import com.issuetracker.dto.label.LabelDto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class IssuePostDto {
    private String title;
    private String content;
    private String imgUrl;
    private Long userId;
    private List<UserDto> userList;
    private List<LabelDto> labelList;
    private Integer milestoneId;
}
