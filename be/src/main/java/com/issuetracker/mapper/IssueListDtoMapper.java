package com.issuetracker.mapper;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import com.issuetracker.domain.IssueListPage;
import com.issuetracker.dto.issue.IssueLabelDto;
import com.issuetracker.dto.issueList.IssueDto;

public class IssueListDtoMapper {
    public static void addIssueDto(Map<Long, IssueDto> issueDtoMap, IssueListPage issueListPage) {
        Set<IssueLabelDto> issueLabelDtoList = new HashSet<>();
        IssueDto issueDto = new IssueDto(issueListPage.getId(), issueListPage.getTitle(), issueListPage.getContent(),
                issueListPage.getUserName(),
                issueListPage.getProfileUrl(), issueListPage.getOpened(), issueListPage.getCreatedAt(),
                issueListPage.getClosedAt(),
                issueListPage.getMilestoneName(), issueLabelDtoList);

        issueDtoMap.put(issueListPage.getId(), issueDto);
    }

    public static void addIssueLabelDto(Map<Long, IssueDto> issueDtoMap, IssueListPage issueListPage) {
        if (issueListPage.getLabelId() != null) {
            issueDtoMap.get(issueListPage.getId())
                    .getLabelList()
                    .add(new IssueLabelDto(issueListPage.getLabelId(), issueListPage.getLabelName(),
                            issueListPage.getBackgroundColor(),
                            issueListPage.getFontColor()));
        }
    }
}
