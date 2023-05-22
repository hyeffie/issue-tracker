package com.issuetracker.dto.milestone;

import com.issuetracker.domain.Milestone;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MilestoneListDto {
    private List<Milestone> milestoneList;

}
