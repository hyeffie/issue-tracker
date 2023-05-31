package com.issuetracker.dto.milestone;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MilestonePageDto {
    private List<MilestoneDto> milestoneList;
    private int countOpenedMilestones;
    private int countClosedMilestones;
    private int countAllMilestones;
    private int countAllLabels;
}
