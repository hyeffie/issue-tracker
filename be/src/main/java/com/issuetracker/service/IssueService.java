package com.issuetracker.service;

import static com.issuetracker.mapper.FilterListMapper.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.issuetracker.domain.Assignee;
import com.issuetracker.domain.Comment;
import com.issuetracker.domain.Issue;
import com.issuetracker.domain.IssueLabel;
import com.issuetracker.domain.Milestone;
import com.issuetracker.domain.User;
import com.issuetracker.dto.issue.IssueCommentDto;
import com.issuetracker.dto.issue.IssueDetailDto;
import com.issuetracker.dto.issue.IssueDetailPageDto;
import com.issuetracker.dto.issue.IssueLabelDto;
import com.issuetracker.dto.issue.IssueMilestone;
import com.issuetracker.dto.issue.IssuePostDto;
import com.issuetracker.dto.issue.IssueStatusDto;
import com.issuetracker.dto.issueList.FilterLabelDto;
import com.issuetracker.dto.issueList.FilterMilestoneDto;
import com.issuetracker.dto.issueList.FilterUserDto;
import com.issuetracker.dto.issueList.IssueStatusListDto;
import com.issuetracker.mapper.LabelToDtoMapper;
import com.issuetracker.repository.AssigneeRepository;
import com.issuetracker.repository.CommentRepository;
import com.issuetracker.repository.IssueLabelRepository;
import com.issuetracker.repository.IssueRepository;
import com.issuetracker.repository.LabelRepository;
import com.issuetracker.repository.MilestoneRepository;
import com.issuetracker.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Slf4j
@Service
@RequiredArgsConstructor
public class IssueService {

    private final IssueRepository issueRepository;
    private final IssueLabelRepository issueLabelRepository;
    private final AssigneeRepository assigneeRepository;
    private final CommentRepository commentRepository;
    private final MilestoneRepository milestoneRepository;
    private final UserRepository userRepository;
    private final LabelRepository labelRepository;

    /**
     * 데이터베이스에서 가져온 데이터들로 이슈 상세 조회 시 필요한 데이터들을 조립
     *
     * @param issueId
     * @return
     */
    public IssueDetailPageDto getIssueDetail(long issueId) {
        // TODO: 데이터베이스에 없는 이슈면 예외처리 (404 NOT FOUND)
        Issue issue = issueRepository.findIssueByIssueId(issueId);
        User user = userRepository.findById(issue.getUserId()).get();
        IssueDetailDto issueDetailDto = new IssueDetailDto(issueId, issue.getTitle(), issue.getContent(),
                user.getLoginId(), user.getProfileUrl(), issue.isOpened(), issue.getCreatedAt(), issue.getClosedAt());

        List<User> assigneeList = issueRepository.findAssigneeListByIssueId(issueId);
        List<IssueLabelDto> labelList = labelRepository.findLabelListByIssueId(issueId).stream()
                .map(LabelToDtoMapper::toDto)
                .collect(Collectors.toList());

        List<IssueCommentDto> commentList = new ArrayList<>();
        for (Comment comment : commentRepository.findCommentListByIssueId(issueId)) {
            User commentWriter = userRepository.findByUserId(comment.getUserId());
            commentList.add(IssueCommentDto.builder()
                    .commentId(comment.getId())
                    .userId(comment.getUserId())
                    .userName(commentWriter.getLoginId())
                    .profileUrl(commentWriter.getProfileUrl())
                    .content(comment.getContent())
                    .createdAt(comment.getCreatedAt())
                    .updatedAt(comment.getUpdatedAt())
                    .build());
        }

        Milestone milestone = milestoneRepository.findMilestoneByIssueId(issueId);
        long countAllIssuesOnMilestone = issueRepository.countAllIssuesOnMilestone(milestone.getId());
        long countAllClosedIssuesOnMilestone = issueRepository.countAllClosedIssuesOnMilestone(milestone.getId());
        IssueMilestone issueMilestone = IssueMilestone.builder()
                .milestoneId(milestone.getId())
                .milestoneName(milestone.getName())
                .countAllIssues(countAllIssuesOnMilestone)
                .countAllClosedIssues(countAllClosedIssuesOnMilestone)
                .build();

        List<FilterLabelDto> filterLabelDtoList = getFilterLabelDtos(
                labelRepository.getFilterLabelList());
        List<FilterMilestoneDto> filterMilestoneList = getFilterMilestoneDtos(
                milestoneRepository.getFilterMilestoneList());
        List<FilterUserDto> filterUserList = getFilterUserDtos(userRepository.getFilterUserList());

        return new IssueDetailPageDto(issueDetailDto, issueMilestone, labelList, assigneeList, commentList,
                filterUserList,
                filterLabelDtoList, filterMilestoneList);
    }

    public void createIssue(IssuePostDto issuePostDto) {
        Issue issue = issueRepository.save(Issue.ofCreated(issuePostDto));

        issuePostDto.getUserList()
                .stream()
                .forEach(userDto -> assigneeRepository.save(Assignee.assign(issue.getId(), userDto.getUserId())));
        issuePostDto.getLabelList()
                .stream()
                .forEach(
                        labelDto -> issueLabelRepository.save(IssueLabel.attach(issue.getId(), labelDto.getLabelId())));
    }

    public void modifyIssueTitle(String title, long id) {
        issueRepository.updateIssueTitle(id, title);
    }

    public void modifyIssueContent(String content, long id) {
        issueRepository.updateIssueContent(id, content);
    }

    public void modifyMilestoneOnIssue(int milestoneId, long id) {
        issueRepository.updateIssueMilestone(id, milestoneId);
    }

    public void modifyAssigneesOnIssue(long id, List<Long> userIdList) {
        assigneeRepository.findByIssueId(id).forEach(assigneeId -> assigneeRepository.deleteById((assigneeId)));
        userIdList.stream()
                .forEach(assigneeId -> assigneeRepository.save(Assignee.assign(id, assigneeId)));
    }

    public void modifyLabelsOnIssue(long id, List<Integer> labelIdList) {
        issueLabelRepository.findByIssueId(id).forEach(issueLabelId -> issueLabelRepository.deleteById(issueLabelId));

        labelIdList.stream()
                .forEach(labelId -> issueLabelRepository.save(IssueLabel.attach(id, labelId)));
    }

    public void deleteIssue(long id) {
        Issue issue = issueRepository.findById(id).get();
        //soft-delete
        issueRepository.save(Issue.ofDeleted(issue));
    }

    @Transactional
    public void changeIssueStatus(IssueStatusListDto issueStatusListDto) {
        //모두 Open이거나 모두 Close인 경우
        long openCount = 0;
        long closeCount = 0;

        Iterator<IssueStatusDto> iterator = issueStatusListDto.getIssues().stream().iterator();
        while (iterator.hasNext()) {
            IssueStatusDto e = iterator.next();
            if (e.getIsOpen() != null && e.getIsOpen()) {
                issueRepository.openIssueById(e.getIssueId());
                openCount++;
            } else if (e.getIsOpen() != null && !e.getIsOpen()) {
                issueRepository.closeIssueById(e.getIssueId(), LocalDateTime.now());
                closeCount++;
            }

            if (openCount > 0 && closeCount > 0) {
                throw new IllegalArgumentException("Open 혹은 Close인 이슈만을 골라주세요.");
            }
        }
    }
}
