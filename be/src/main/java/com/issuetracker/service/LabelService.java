package com.issuetracker.service;

import com.issuetracker.domain.Label;
import com.issuetracker.dto.label.LabelDto;
import com.issuetracker.dto.label.LabelListDto;
import com.issuetracker.repository.LabelRepository;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class LabelService {

    private final LabelRepository labelRepository;

    public LabelListDto findAllLabels() {
        List<Label> labelList = labelRepository.findAllLabels();

        return new LabelListDto(labelList, labelList.size());
    }

    public void createLabel(LabelDto labelDto) {
        labelRepository.save(
                Label.createAutoIncrementedLabel(labelDto.getLabelName(), labelDto.getBackgroundColor(),
                        labelDto.getFontColor(), labelDto.getDescription()));
    }

    public void updateLabel(int labelId, LabelDto labelDto) {
        labelRepository.save(Label.createUpdateLabel(labelId, labelDto.getLabelName(), labelDto.getBackgroundColor(),
                labelDto.getFontColor(), labelDto.getDescription()));
    }

    public void deleteLabelById(int labelId) {
        Label label = labelRepository.findById((long)labelId)
                .orElseThrow(() -> new IllegalArgumentException("없는 라벨입니다."));

        labelRepository.save(Label.ofDeleted(labelId, label.getName(), label.getBackgroundColor(),
                label.getFontColor(), label.getDescription()));
    }
}
