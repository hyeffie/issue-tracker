package com.issuetracker.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.issuetracker.domain.Assignee;
import com.issuetracker.domain.Issue;
import com.issuetracker.domain.IssueLabel;
import com.issuetracker.dto.issue.AssigneeDto;
import com.issuetracker.dto.issue.IssueCommentDto;
import com.issuetracker.dto.issue.IssueDetailDto;
import com.issuetracker.dto.issue.IssueDetailPageDto;
import com.issuetracker.dto.issue.IssueLabelDto;
import com.issuetracker.dto.issue.IssueMilestone;
import com.issuetracker.dto.issue.IssuePostDto;
import com.issuetracker.dto.issue.UserDto;
import com.issuetracker.repository.AssigneeRepository;
import com.issuetracker.repository.IssueLabelRepository;
import com.issuetracker.repository.IssueRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class IssueService {

    private final IssueRepository issueRepository;
    private final IssueLabelRepository issueLabelRepository;
    private final AssigneeRepository assigneeRepository;

    /**
     * 데이터베이스에서 가져온 데이터들로 이슈 상세 조회 시 필요한 데이터들을 조립
     * @param issueId
     * @return
     */
    public IssueDetailPageDto getIssueDetail(long issueId) {
        IssueDetailDto issue = issueRepository.findIssueByIssueId(issueId);
        List<AssigneeDto> assigneeList = issueRepository.findAssigneeListByIssueId(issueId);
        List<IssueLabelDto> labelList = issueRepository.findLabelListByIssueId(issueId);
        List<IssueCommentDto> commentList = issueRepository.findCommentListByIssueId(issueId);
        IssueMilestone milestone = issueRepository.findMilestoneByIssueId(issueId);
        return new IssueDetailPageDto(issue, milestone, labelList, assigneeList, commentList);
    }

    public void createIssue(IssuePostDto issuePostDto) {
        Issue issue = issueRepository.save(Issue.createIssue(issuePostDto));

        issuePostDto.getUserList()
                .stream()
                .forEach(userDto -> assigneeRepository.save(Assignee.assign(issue.getId(), userDto.getUserId())));
        issuePostDto.getLabelList().stream().forEach(labelDto -> issueLabelRepository.save(IssueLabel.attach(
                issue.getId(), labelDto.getLabelId())));
    }
}
