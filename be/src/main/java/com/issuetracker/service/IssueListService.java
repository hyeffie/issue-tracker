package com.issuetracker.service;

import static com.issuetracker.mapper.FilterListMapper.*;
import static com.issuetracker.mapper.IssueListDtoMapper.*;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.issuetracker.domain.IssueListPage;
import com.issuetracker.dto.issueList.Filter;
import com.issuetracker.dto.issueList.FilterLabelDto;
import com.issuetracker.dto.issueList.FilterMilestoneDto;
import com.issuetracker.dto.issueList.FilterUserDto;
import com.issuetracker.dto.issueList.IssueDto;
import com.issuetracker.dto.issueList.IssueListDto;
import com.issuetracker.mapper.IssueListMapper;
import com.issuetracker.repository.IssueListRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class IssueListService {
    private final IssueListRepository issueListRepository;
    private final IssueListMapper issueListMapper;

    /**
     * 이슈 목록을 가져온 후 API의 형식에 맞춰서 mapping한 후, filter 목록 데이터 DTO와 함께 조립합니다.
     * 이슈를 가져올 때 여러 테이블을 Join하여 가져오므로 DB의 중복 데이터가 많습니다.(n:m, 1:n 관계 - 예를 들면 issue : label을 가져오는 경우)
     * 동일 이슈에 대해서 여러 개의 라벨을 Issue 객체에 list 타입으로 넣어주기 위해서 다소 지저분한 mapping 로직으로 구현했습니다.
     */
    public IssueListDto fetchMain(Filter filterDto) {

        List<IssueListPage> filteredIssueList = issueListMapper.findIssueList(filterDto);

        List<IssueListPage> issueMainPageDtoList = new ArrayList<>();

        for (IssueListPage issueListPage : filteredIssueList) {
            issueListRepository.getIssues(issueListPage.getId()).forEach(e -> issueMainPageDtoList.add(e));
        }

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

        List<FilterLabelDto> filterLabelDtoList = getFilterLabelDtos(issueListRepository.getFilterLabelList());
        List<FilterMilestoneDto> filterMilestoneList = getFilterMilestoneDtos(issueListRepository.getFilterMilestoneList());
        List<FilterUserDto> filterUserList = getFilterUserDtos(issueListRepository.getFilterUserList());

        long openedIssues = issueDtoList.stream().filter(issueDto -> issueDto.isOpen()).count();
        long closedIssues = issueListRepository.getTotalClosedIssueCount();
        return new IssueListDto(issueDtoList, filterUserList, filterLabelDtoList, filterMilestoneList,
                filterLabelDtoList.size(), filterMilestoneList.size(), openedIssues, closedIssues);
    }

}
