package com.issuetracker.service;

import com.issuetracker.domain.Assignee;
import com.issuetracker.domain.Issue;
import com.issuetracker.domain.IssueLabel;
import com.issuetracker.dto.issue.*;
import com.issuetracker.repository.AssigneeRepository;
import com.issuetracker.repository.IssueLabelRepository;
import com.issuetracker.repository.IssueRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class IssueService {

    private final IssueRepository issueRepository;
    private final IssueLabelRepository issueLabelRepository;
    private final AssigneeRepository assigneeRepository;

    /**
     * 데이터베이스에서 가져온 데이터들로 이슈 상세 조회 시 필요한 데이터들을 조립
     *
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

    public void modifyIssue(IssuePostDto issuePostDto, long id) {
        Issue issueUnmodified = issueRepository.findById(id).get();
        Issue issue = issueRepository.save(Issue.updateIssue(issuePostDto, issueUnmodified, id));
        //Label, Assignee 삭제 후 다시 추가
        assigneeRepository.findByIssueId(id).forEach(assigneeId -> assigneeRepository.deleteById((assigneeId)));
        issueLabelRepository.findByIssueId(id).forEach(issueLabelId -> issueLabelRepository.deleteById(issueLabelId));
        issuePostDto.getUserList().stream()
                .forEach(userDto -> assigneeRepository.save(Assignee.assign(issue.getId(), userDto.getUserId())));
        issuePostDto.getLabelList().stream()
                .forEach(labelDto -> issueLabelRepository.save(IssueLabel.attach(issue.getId(), labelDto.getLabelId())));
    }

    public void deleteIssue(long id) {
        Issue issue = issueRepository.findById(id).get();
        //soft-delete
        issueRepository.save(Issue.deleteIssue(issue));
    }
}
