package com.issuetracker.service;

import com.issuetracker.domain.Milestone;
import com.issuetracker.dto.milestone.MilestoneDto;
import com.issuetracker.dto.milestone.MilestonePageDto;
import com.issuetracker.repository.LabelRepository;
import com.issuetracker.repository.MilestoneRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class MilestoneService {

    private final MilestoneRepository milestoneRepository;
    private final LabelRepository labelRepository;

    public MilestonePageDto findAllMilestones() {

        List<Milestone> milestoneList = milestoneRepository.findAllMilestones();
        List<MilestoneDto> milestoneDtoList = new ArrayList<>();

        for (Milestone milestone : milestoneList) {
            int milestoneId = milestone.getId();
            long countOpenedIssues = milestoneRepository.countOpenedIssuesByMilestoneId(milestoneId);
            long countClosedIssues = milestoneRepository.countClosedIssuesByMilestoneId(milestoneId);
            int progress = 0;
            if (countClosedIssues + countOpenedIssues != 0) {
                progress = (int) (100 * ((double) countClosedIssues / (countOpenedIssues + countClosedIssues)));
            }

            milestoneDtoList.add(new MilestoneDto(milestoneId,
                    milestone.getName(),
                    milestone.getDescription(),
                    milestone.getCompletedAt(),
                    milestone.isOpened(),
                    countOpenedIssues, countClosedIssues, progress));
        }

        int countOpenedMilestones = milestoneRepository.countOpenedMilestones();
        int countClosedMilestones = milestoneRepository.countClosedMilestones();
        int countAllMilestones = countOpenedMilestones + countClosedMilestones;
        int countAllLabels = labelRepository.countAllLabels();

        return new MilestonePageDto(milestoneDtoList, countOpenedMilestones, countClosedMilestones, countAllMilestones, countAllLabels);
    }

    public void createMilestone(MilestoneDto milestoneDto) {
        milestoneRepository.save(Milestone.ofCreated(milestoneDto.getName(), milestoneDto.getDescription(), milestoneDto.getCompletedAt()));
    }

    public void updateMilestone(int milestoneId, MilestoneDto milestoneDto) {
        milestoneRepository.save(Milestone.ofUpdated(milestoneId, milestoneDto.getName(), milestoneDto.getDescription(), milestoneDto.getCompletedAt(), milestoneDto.getIsOpen()));
    }

    public void deleteMilestone(int milestoneId) {
        Milestone milestone = milestoneRepository.findById((long) milestoneId)
                        .orElseThrow(() -> new IllegalArgumentException("없는 마일스톤입니다."));

        milestoneRepository.save(Milestone.ofDeleted(milestoneId, milestone.getName(), milestone.getDescription(),
                milestone.getCompletedAt(), milestone.isOpened()));
    }
}
