package com.issuetracker.dto.label;

import java.util.List;

import com.issuetracker.domain.Label;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LabelListDto {
    private List<Label> labelList;
    private int countAllLabels;
    private int countAllMilestones;
}
