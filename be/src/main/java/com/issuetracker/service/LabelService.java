package com.issuetracker.service;

import com.issuetracker.dto.IssueDto;
import com.issuetracker.dto.IssueLabelDto;
import com.issuetracker.dto.IssueListDto;
import com.issuetracker.dto.IssueDao;
import com.issuetracker.repository.LabelRepository;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class LabelService {
    private final LabelRepository labelRepository;

    public IssueListDto fetchMain() {
        IssueListDto issueListDto = new IssueListDto();
        List<IssueDao> issueMainPageDtoList = labelRepository.getIssues();
        //IssueDao -> IssueDto로 변환
        List<IssueDto> issueDtoList = new ArrayList<>();
        for (int i = 0; i < issueMainPageDtoList.size(); i++) {
            IssueDao issueDao = issueMainPageDtoList.get(i);
            long id = issueDao.getId();
            List<IssueLabelDto> issueLabelDtoList = new ArrayList<>();
            while (i < issueMainPageDtoList.size() && id == issueDao.getId()) {
                issueLabelDtoList.add(
                        new IssueLabelDto(issueDao.getLabelId(), issueDao.getLabelName(), issueDao.getBackgroundColor(),
                                issueDao.getFontColor()));
                i++;
                if (i < issueMainPageDtoList.size()) {
                    issueDao = issueMainPageDtoList.get(i);
                }
            }

            issueDtoList.add(new IssueDto(id, issueDao.getTitle(), issueDao.getContent(), issueDao.getUserName(),
                    issueDao.getProfileUrl(), issueDao.getOpened(), issueDao.getCreatedAt(), issueDao.getClosedAt(),
                    issueDao.getMilestoneName(), issueLabelDtoList));

        }
        issueListDto.setIssues(issueDtoList);
        return issueListDto;
    }

}
