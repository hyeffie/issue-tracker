package com.issuetracker.controller;

import com.issuetracker.dto.milestone.MilestoneDto;
import com.issuetracker.dto.milestone.MilestonePageDto;
import com.issuetracker.service.MilestoneService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
public class MilestoneController {

    private final MilestoneService milestoneService;

    @GetMapping("/api/milestones")
    public MilestonePageDto getMilestones() {
        return milestoneService.findAllMilestones();
    }

    @PostMapping("/api/milestones")
    public void create(@RequestBody MilestoneDto milestoneDto) {
        milestoneService.createMilestone(milestoneDto);
    }

    @PatchMapping("/api/milestones/{milestoneId}")
    public void update(@PathVariable int milestoneId, @RequestBody MilestoneDto milestoneDto) {
        milestoneService.updateMilestone(milestoneId, milestoneDto);
    }

    @DeleteMapping("/api/milestones/{milestoneId}")
    public void delete(@PathVariable int milestoneId) {
        milestoneService.deleteMilestone(milestoneId);
    }
}
