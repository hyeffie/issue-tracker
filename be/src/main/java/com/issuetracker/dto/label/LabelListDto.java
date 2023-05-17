package com.issuetracker.dto.label;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class LabelListDto {
    private List<LabelDto> labelList;
    private int countAllLabels;
}
