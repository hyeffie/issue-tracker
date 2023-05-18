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
