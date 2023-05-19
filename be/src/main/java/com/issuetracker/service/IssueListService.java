package com.issuetracker.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.issuetracker.dto.issueList.FilterLabelDto;
import com.issuetracker.dto.issueList.FilterMilestoneDto;
import com.issuetracker.dto.issueList.FilterUserDto;
import com.issuetracker.dto.issueList.IssueDao;
import com.issuetracker.dto.issueList.IssueDto;

import com.issuetracker.dto.issueList.IssueListDto;
import com.issuetracker.dto.issue.IssueLabelDto;
import com.issuetracker.repository.IssueListRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class IssueListService {
    private final IssueListRepository labelRepository;

    /**
     * 이슈 목록을 가져온 후 API의 형식에 맞춰서 mapping한 후, filter 목록 데이터 DTO와 함께 조립합니다.
     * 이슈를 가져올 때 여러 테이블을 Join하여 가져오므로 DB의 중복 데이터가 많습니다.(n:m, 1:n 관계 - 예를 들면 issue : label을 가져오는 경우)
     * 동일 이슈에 대해서 여러 개의 라벨을 Issue 객체에 list 타입으로 넣어주기 위해서 다소 지저분한 mapping 로직으로 구현했습니다.
     */
    public IssueListDto fetchMain() {
        IssueListDto issueListDto = new IssueListDto();
        List<IssueDao> issueMainPageDtoList = labelRepository.getIssues(true);

        List<IssueDto> issueDtoList = new ArrayList<>();
        for (int i = 0; i < issueMainPageDtoList.size(); i++) {
            IssueDao issueDao = issueMainPageDtoList.get(i);
            long id = issueDao.getId();
            List<IssueLabelDto> issueLabelDtoList = new ArrayList<>();
            IssueDto issueDto = new IssueDto(id, issueDao.getTitle(), issueDao.getContent(), issueDao.getUserName(),
                    issueDao.getProfileUrl(), issueDao.getOpened(), issueDao.getCreatedAt(), issueDao.getClosedAt(),
                    issueDao.getMilestoneName(), issueLabelDtoList);
            Boolean flag = false;
            while (i < issueMainPageDtoList.size() && id == issueDao.getId()) {
                flag = true;
                if (issueDao.getLabelId() != null) {
                    issueLabelDtoList.add(
                            new IssueLabelDto(issueDao.getLabelId(), issueDao.getLabelName(),
                                    issueDao.getBackgroundColor(),
                                    issueDao.getFontColor()));
                }
                i++;
                if (i < issueMainPageDtoList.size()) {
                    issueDao = issueMainPageDtoList.get(i);
                }
            }
            issueDtoList.add(issueDto);
            if (flag) {
                i--;
            }
        }
        issueListDto.setIssues(issueDtoList);
        issueListDto.setUserList(fetchFilterUsers());
        List<FilterLabelDto> filterLabelDtoList = fetchFilterLabels();
        issueListDto.setLabelList(filterLabelDtoList);
        List<FilterMilestoneDto> filterMilestoneDtoList = fetchFilterMilestones();
        issueListDto.setMilestoneList(filterMilestoneDtoList);

        issueListDto.setCountAllLabels(filterLabelDtoList.size());
        issueListDto.setCountAllMilestones(filterMilestoneDtoList.size());
        issueListDto.setCountOpenedIssues(issueDtoList.stream().filter(issueDto -> issueDto.getIsOpen()).count());
        issueListDto.setCountClosedIssues(labelRepository.getTotalClosedIssueCount());
        return issueListDto;
    }

    public List<FilterUserDto> fetchFilterUsers() {
        return labelRepository.getFilterUserList();
    }

    public List<FilterLabelDto> fetchFilterLabels() {
        return labelRepository.getFilterLabelList();
    }

    public List<FilterMilestoneDto> fetchFilterMilestones() {
        return labelRepository.getFilterMilestoneList();
    }

}
