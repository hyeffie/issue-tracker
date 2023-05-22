package com.issuetracker.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.issuetracker.dto.issue.AssigneeDto;
import com.issuetracker.dto.issue.IssueCommentDto;
import com.issuetracker.dto.issue.IssueDetailDto;
import com.issuetracker.dto.issue.IssueDetailPageDto;
import com.issuetracker.dto.issue.IssueLabelDto;
import com.issuetracker.dto.issue.IssueMilestone;
import com.issuetracker.repository.IssueRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class IssueService {

    private final IssueRepository issueRepository;

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
}
