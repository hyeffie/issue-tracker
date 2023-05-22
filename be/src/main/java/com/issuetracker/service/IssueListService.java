package com.issuetracker.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.issuetracker.domain.Issue;
import com.issuetracker.domain.Label;
import com.issuetracker.domain.Milestone;
import com.issuetracker.domain.User;
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
        List<Issue> issueMainPageDtoList = issueListRepository.getIssues(true);

        List<IssueDto> issueDtoList = new ArrayList<>();
        for (int i = 0; i < issueMainPageDtoList.size(); i++) {
            Issue issueDao = issueMainPageDtoList.get(i);
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

        List<Label> filterLabelList = issueListRepository.getFilterLabelList();
        //mapping
        List<FilterLabelDto> filterLabelDtoList = new ArrayList<>();
        for (Label label : filterLabelList) {
            filterLabelDtoList.add(
                    new FilterLabelDto(label.getId(), label.getName(), label.getBackgroundColor(), label.getFontColor(),
                            label.getDescription()));
        }

        List<Milestone> filterMilestoneList = issueListRepository.getFilterMilestoneList();
        List<FilterMilestoneDto> filterMilestoneDtoList = new ArrayList<>();
        for (Milestone milestone : filterMilestoneList) {
            filterMilestoneDtoList.add(
                    new FilterMilestoneDto(milestone.getId(), milestone.getName(), milestone.getDescription()));
        }

        List<User> filterUserList = issueListRepository.getFilterUserList();
        List<FilterUserDto> filterUserDtoList = new ArrayList<>();
        for (User user : filterUserList) {
            filterUserDtoList.add(new FilterUserDto(user.getId(), user.getLoginId(), user.getProfileUrl()));
        }

        int openedIssues = (int)issueDtoList.stream().filter(issueDto -> issueDto.isOpen()).count();
        int closedIssues = (int)issueListRepository.getTotalClosedIssueCount();
        return new IssueListDto(issueDtoList, filterUserDtoList, filterLabelDtoList, filterMilestoneDtoList,
                filterLabelDtoList.size(), filterMilestoneDtoList.size(), openedIssues, closedIssues);
    }
}
