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

    /**
     * 이슈 목록을 가져온 후 API의 형식에 맞춰서 mapping한 후, filter 목록 데이터 DTO와 함께 조립합니다.
     * 이슈를 가져올 때 여러 테이블을 Join하여 가져오므로 DB의 중복 데이터가 많습니다.(n:m, 1:n 관계 - 예를 들면 issue : label을 가져오는 경우)
     * 동일 이슈에 대해서 여러 개의 라벨을 Issue 객체에 list 타입으로 넣어주기 위해서 다소 지저분한 mapping 로직으로 구현했습니다.
     */
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

        int openedIssues = (int)issueDtoList.stream().filter(issueDto -> issueDto.isOpen()).count();
        int closedIssues = (int)issueListRepository.getTotalClosedIssueCount();
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
