package com.issuetracker.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.issuetracker.dto.IssueDto;
import com.issuetracker.dto.FilterLabelDto;
import com.issuetracker.dto.IssueLabelDto;
import com.issuetracker.dto.IssueListDto;
import com.issuetracker.dto.FilterMilestoneDto;
import com.issuetracker.dto.FilterUserDto;

@RestController
public class IssueListController {

    @GetMapping("api/")
    public IssueListDto home() {
        List<IssueDto> issues = new ArrayList<>();
        List<FilterUserDto> userList = new ArrayList<>();
        List<FilterLabelDto> labelList = new ArrayList<>();
        List<FilterMilestoneDto> milestoneList = new ArrayList<>();

        List<IssueLabelDto> issueLabelList = new ArrayList();
        issueLabelList.add(new IssueLabelDto(1, "라벨이름", "x000000", "x111111"));

        labelList.add(new FilterLabelDto(1, "라벨이름", "x000000", "x111111", "백엔드 라벨"));
        userList.add(new FilterUserDto(1, "luke", "프사"));
        milestoneList.add(new FilterMilestoneDto(1, "마일스톤", "설명", 2, 1));
        issues.add(new IssueDto(1, "나는 이슈다", "내용", "루크", "프사", true, "now", "내일", "마이 마일스톤", issueLabelList));

        IssueListDto issueListDto = new IssueListDto(issues, userList, labelList, milestoneList, 1,2,3,4);
        return issueListDto;
    }
}
