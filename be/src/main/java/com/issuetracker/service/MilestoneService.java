package com.issuetracker.service;

import com.issuetracker.domain.Milestone;
import com.issuetracker.dto.milestone.MilestoneDto;
import com.issuetracker.dto.milestone.MilestoneListDto;
import com.issuetracker.repository.MilestoneRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class MilestoneService {

    private final MilestoneRepository milestoneRepository;

    public MilestoneListDto findAllMilestones() {

        List<Milestone> milestoneList = milestoneRepository.findAllMilestones();


        return new MilestoneListDto();
    }
}
