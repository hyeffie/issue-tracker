package com.issuetracker.controller;

import com.issuetracker.dto.milestone.MilestoneDto;
import com.issuetracker.dto.milestone.MilestonePageDto;
import com.issuetracker.service.MilestoneService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class MilestoneController {

    private final MilestoneService milestoneService;

    @GetMapping("/api/milestones")
    public MilestonePageDto getMilestones() {
        return milestoneService.findAllMilestones();
    }
}
