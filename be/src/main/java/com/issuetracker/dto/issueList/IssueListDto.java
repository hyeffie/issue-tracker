package com.issuetracker.dto.issueList;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.issuetracker.domain.IssueListPage;
import com.issuetracker.mapper.IssueListDtoMapper;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class IssueListDto {
    private List<IssueDto> issues;
    private List<FilterUserDto> userList;
    private List<FilterLabelDto> labelList;
    private List<FilterMilestoneDto> milestoneList;
    private int countAllLabels;
    private int countAllMilestones;
    private long countOpenedIssues;
    private long countClosedIssues;

    public static IssueListDto of(List<IssueListPage> issueMainPageDtoList, List<FilterUserDto> filterUserDtoList,
            List<FilterLabelDto> filterLabelDtoList, List<FilterMilestoneDto> filterMilestoneDtoList, long countOpenedIssues, long countClosedIssues) {

        Map<Long, IssueDto> issueDtoMap = new LinkedHashMap<>();
        for (IssueListPage issueListPage : issueMainPageDtoList) {
            if (issueDtoMap.containsKey(issueListPage.getId())) {
                IssueListDtoMapper.addIssueLabelDto(issueDtoMap, issueListPage);
            } else {
                IssueListDtoMapper.addIssueDto(issueDtoMap, issueListPage);
                IssueListDtoMapper.addIssueLabelDto(issueDtoMap, issueListPage);
            }
        }
        List<IssueDto> issueDtoList = issueDtoMap.values().stream().collect(Collectors.toList());

        return IssueListDto.builder()
                .issues(issueDtoList)
                .userList(filterUserDtoList)
                .labelList(filterLabelDtoList)
                .milestoneList(filterMilestoneDtoList)
                .countAllLabels(filterLabelDtoList.size())
                .countAllMilestones(filterMilestoneDtoList.size())
                .countOpenedIssues(countOpenedIssues)
                .countClosedIssues(countClosedIssues)
                .build();
    }
}
