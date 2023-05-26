package com.issuetracker.service;

import static com.issuetracker.mapper.FilterListMapper.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.issuetracker.domain.Assignee;
import com.issuetracker.domain.Issue;
import com.issuetracker.domain.IssueLabel;
import com.issuetracker.domain.User;
import com.issuetracker.dto.issue.AssigneeDto;
import com.issuetracker.dto.issue.IssueCommentDto;
import com.issuetracker.dto.issue.IssueDetailDto;
import com.issuetracker.dto.issue.IssueDetailPageDto;
import com.issuetracker.dto.issue.IssueLabelDto;
import com.issuetracker.dto.issue.IssueMilestone;
import com.issuetracker.dto.issue.IssuePostDto;
import com.issuetracker.dto.issueList.FilterLabelDto;
import com.issuetracker.dto.issueList.FilterMilestoneDto;
import com.issuetracker.dto.issueList.FilterUserDto;
import com.issuetracker.dto.issueList.IssueStatusListDto;
import com.issuetracker.mapper.LabelToDtoMapper;
import com.issuetracker.repository.AssigneeRepository;
import com.issuetracker.repository.IssueLabelRepository;
import com.issuetracker.repository.IssueListRepository;
import com.issuetracker.repository.IssueRepository;
import com.issuetracker.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class IssueService {

    private final IssueRepository issueRepository;
    private final IssueLabelRepository issueLabelRepository;
    private final AssigneeRepository assigneeRepository;
    private final IssueListRepository issueListRepository;
    private final UserRepository userRepository;

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
                user.getLoginId(), user.getProfileUrl(), issue.getOpened(), issue.getCreatedAt(), issue.getClosedAt());

        List<AssigneeDto> assigneeList = issueRepository.findAssigneeListByIssueId(issueId);
        List<IssueLabelDto> labelList = issueRepository.findLabelListByIssueId(issueId).stream()
                .map(LabelToDtoMapper.INSTANCE::toDto)
                .collect(Collectors.toList());
        List<IssueCommentDto> commentList = issueRepository.findCommentListByIssueId(issueId);
        IssueMilestone milestone = issueRepository.findMilestoneByIssueId(issueId);

        List<FilterLabelDto> filterLabelDtoList = getFilterLabelDtos(issueListRepository.getFilterLabelList());
        List<FilterMilestoneDto> filterMilestoneList = getFilterMilestoneDtos(
                issueListRepository.getFilterMilestoneList());
        List<FilterUserDto> filterUserList = getFilterUserDtos(issueListRepository.getFilterUserList());

        return new IssueDetailPageDto(issueDetailDto, milestone, labelList, assigneeList, commentList, filterUserList,
                filterLabelDtoList, filterMilestoneList);
    }

    public void createIssue(IssuePostDto issuePostDto) {
        Issue issue = issueRepository.save(Issue.createIssue(issuePostDto));

        issuePostDto.getUserList()
                .stream()
                .forEach(userDto -> assigneeRepository.save(Assignee.assign(issue.getId(), userDto.getUserId())));
        issuePostDto.getLabelList()
                .stream()
                .forEach(
                        labelDto -> issueLabelRepository.save(IssueLabel.attach(issue.getId(), labelDto.getLabelId())));
    }

    public void modifyIssue(IssuePostDto issuePostDto, long id) {
        Issue issueUnmodified = issueRepository.findById(id).get();
        Issue issue = issueRepository.save(Issue.updateIssue(issuePostDto, issueUnmodified, id));
        //Label, Assignee 삭제 후 다시 추가
        assigneeRepository.findByIssueId(id).forEach(assigneeId -> assigneeRepository.deleteById((assigneeId)));
        issueLabelRepository.findByIssueId(id).forEach(issueLabelId -> issueLabelRepository.deleteById(issueLabelId));
        issuePostDto.getUserList()
                .stream()
                .forEach(userDto -> assigneeRepository.save(Assignee.assign(issue.getId(), userDto.getUserId())));
        issuePostDto.getLabelList()
                .stream()
                .forEach(
                        labelDto -> issueLabelRepository.save(IssueLabel.attach(issue.getId(), labelDto.getLabelId())));
    }

    public void deleteIssue(long id) {
        Issue issue = issueRepository.findById(id).get();
        //soft-delete
        issueRepository.save(Issue.deleteIssue(issue));
    }

    public void changeIssueStatus(IssueStatusListDto is) {
        //모두 Open이거나 모두 Close인 경우
        if (is.getIssues().stream().filter(e -> e.getIsOpen() != null && e.getIsOpen()).count() == is.getIssues()
                .size()) {
            is.getIssues().stream().forEach(e -> issueRepository.openIssueById(e.getIssueId()));
            return;
        } else if (is.getIssues().stream().filter(e -> e.getIsOpen() != null && !e.getIsOpen()).count()
                == is.getIssues().size()) {
            is.getIssues().stream().forEach(e -> issueRepository.closeIssueById(e.getIssueId(), LocalDateTime.now()));
            return;
        }
        throw new IllegalArgumentException("Open 혹은 Close인 이슈만을 골라주세요.");
    }
}
