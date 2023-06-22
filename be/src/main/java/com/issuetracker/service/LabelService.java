package com.issuetracker.service;

import com.issuetracker.domain.Label;
import com.issuetracker.dto.label.LabelDto;
import com.issuetracker.dto.label.LabelListDto;
import com.issuetracker.repository.LabelRepository;

import com.issuetracker.repository.MilestoneRepository;
import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class LabelService {

    private final LabelRepository labelRepository;
    private final MilestoneRepository milestoneRepository;

    public LabelListDto findAllLabels() {
        List<Label> labelList = labelRepository.findAllLabels();
        int countAllMilestones = milestoneRepository.countAllMilestones();

        return new LabelListDto(labelList, labelList.size(), countAllMilestones);
    }

    public void createLabel(LabelDto labelDto) {
        labelRepository.save(
                Label.ofCreated(labelDto.getLabelName(), labelDto.getBackgroundColor(),
                        labelDto.getFontColor(), labelDto.getDescription()));
    }

    public void updateLabel(int labelId, LabelDto labelDto) {
        labelRepository.save(Label.ofUpdated(labelId, labelDto.getLabelName(), labelDto.getBackgroundColor(),
                labelDto.getFontColor(), labelDto.getDescription()));
    }

    public void deleteLabelById(int labelId) {
        Label label = labelRepository.findById((long)labelId)
                .orElseThrow(() -> new IllegalArgumentException("없는 라벨입니다."));

        labelRepository.save(Label.ofDeleted(labelId, label.getName(), label.getBackgroundColor(),
                label.getFontColor(), label.getDescription()));
    }
}
