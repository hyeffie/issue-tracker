package com.issuetracker.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.issuetracker.domain.IssueListPage;
import com.issuetracker.dto.issueList.Filter;
import com.issuetracker.dto.issueList.FilterLabelDto;
import com.issuetracker.dto.issueList.FilterMilestoneDto;
import com.issuetracker.dto.issueList.FilterUserDto;
import com.issuetracker.dto.issueList.IssueListDto;
import com.issuetracker.mapper.FilterListMapper;
import com.issuetracker.mapper.IssueIdListMapper;
import com.issuetracker.mapper.IssueListMapper;
import com.issuetracker.repository.IssueRepository;
import com.issuetracker.repository.LabelRepository;
import com.issuetracker.repository.MilestoneRepository;
import com.issuetracker.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class IssueListService {
    private final IssueRepository issueRepository;
    private final IssueListMapper issueListMapper;
    private final IssueIdListMapper issueIdListMapper;
    private final UserRepository userRepository;
    private final LabelRepository labelRepository;
    private final MilestoneRepository milestoneRepository;

    /**
     * 이슈 목록을 가져온 후 API의 형식에 맞춰서 mapping한 후, filter 목록 데이터 DTO와 함께 조립합니다.
     * 이슈를 가져올 때 여러 테이블을 Join하여 가져오므로 DB의 중복 데이터가 많습니다.(n:m, 1:n 관계 - 예를 들면 issue : label을 가져오는 경우)
     * 동일 이슈에 대해서 여러 개의 라벨을 Issue 객체에 list 타입으로 넣어주기 위해서 다소 지저분한 mapping 로직으로 구현했습니다.
     */
    public IssueListDto fetchMain(Filter filterDto) {

        List<Long> filteredIssueIdList = issueIdListMapper.findIssueIdList(filterDto);
        List<IssueListPage> issueMainPageDtoList = new ArrayList<>();
        if (filteredIssueIdList.size() != 0) {
            issueMainPageDtoList = issueListMapper.findIssueList(filteredIssueIdList);
        }
        List<FilterLabelDto> filterLabelDtoList = FilterListMapper.getFilterLabelDtos(
                labelRepository.getFilterLabelList());
        List<FilterMilestoneDto> filterMilestoneList = FilterListMapper.getFilterMilestoneDtos(
                milestoneRepository.getFilterMilestoneList());
        List<FilterUserDto> filterUserList = FilterListMapper.getFilterUserDtos(userRepository.getFilterUserList());

        long openedIssues = issueRepository.getTotalOpendIssueCount();
        long closedIssues = issueRepository.getTotalClosedIssueCount();

        return IssueListDto.of(issueMainPageDtoList, filterUserList, filterLabelDtoList, filterMilestoneList,
                openedIssues, closedIssues);
    }

}
