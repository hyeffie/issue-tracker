package com.issuetracker.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.issuetracker.domain.IssueListPage;
import com.issuetracker.dto.issue.IssueLabelDto;
import com.issuetracker.dto.issueList.FilterLabelDto;
import com.issuetracker.dto.issueList.FilterMilestoneDto;
import com.issuetracker.dto.issueList.FilterUserDto;
import com.issuetracker.dto.issueList.IssueDto;
import com.issuetracker.dto.issueList.IssueListDto;
import com.issuetracker.repository.IssueListRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class IssueListService {
    private final IssueListRepository issueListRepository;

    public IssueListDto fetchMain() {
        List<IssueListPage> issueMainPageDtoList = issueListRepository.getIssues(true);

        Map<Long, IssueDto> issueDtoMap = new LinkedHashMap<>();
        for (IssueListPage issueListPage : issueMainPageDtoList) {
            if (issueDtoMap.containsKey(issueListPage.getId())) {
                addIssueLabelDto(issueDtoMap, issueListPage);
            } else {
                addIssueDto(issueDtoMap, issueListPage);
                addIssueLabelDto(issueDtoMap, issueListPage);
            }
        }
        List<IssueDto> issueDtoList = issueDtoMap.values().stream().collect(Collectors.toList());

        List<FilterLabelDto> filterLabelDtoList = issueListRepository.getFilterLabelList().stream()
                .map(label -> new FilterLabelDto(label.getId(), label.getName(), label.getBackgroundColor(),
                        label.getFontColor(), label.getDescription()))
                .collect(Collectors.toUnmodifiableList());

        List<FilterMilestoneDto> filterMilestoneList = issueListRepository.getFilterMilestoneList().stream()
                .map(milestone -> new FilterMilestoneDto(milestone.getId(), milestone.getName(),
                        milestone.getDescription()))
                .collect(Collectors.toUnmodifiableList());

        List<FilterUserDto> filterUserList = issueListRepository.getFilterUserList().stream()
                .map(user -> new FilterUserDto(user.getId(), user.getLoginId(), user.getProfileUrl()))
                .collect(Collectors.toUnmodifiableList());

        long openedIssues = issueDtoList.stream().filter(issueDto -> issueDto.isOpen()).count();
        long closedIssues = issueListRepository.getTotalClosedIssueCount();
        return new IssueListDto(issueDtoList, filterUserList, filterLabelDtoList, filterMilestoneList,
                filterLabelDtoList.size(), filterMilestoneList.size(), openedIssues, closedIssues);
    }

    private static void addIssueDto(Map<Long, IssueDto> issueDtoMap, IssueListPage issueListPage) {
        List<IssueLabelDto> issueLabelDtoList = new ArrayList<>();
        IssueDto issueDto = new IssueDto(issueListPage.getId(), issueListPage.getTitle(), issueListPage.getContent(),
                issueListPage.getUserName(),
                issueListPage.getProfileUrl(), issueListPage.getOpened(), issueListPage.getCreatedAt(),
                issueListPage.getClosedAt(),
                issueListPage.getMilestoneName(), issueLabelDtoList);

        issueDtoMap.put(issueListPage.getId(), issueDto);
    }

    private static void addIssueLabelDto(Map<Long, IssueDto> issueDtoMap, IssueListPage issueListPage) {
        if (issueListPage.getLabelId() != null) {
            issueDtoMap.get(issueListPage.getId())
                    .getLabelList()
                    .add(new IssueLabelDto(issueListPage.getLabelId(), issueListPage.getLabelName(),
                            issueListPage.getBackgroundColor(),
                            issueListPage.getFontColor()));
        }
    }
}
