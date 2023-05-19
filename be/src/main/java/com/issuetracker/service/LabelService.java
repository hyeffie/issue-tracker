package com.issuetracker.service;

import com.issuetracker.domain.Label;
import com.issuetracker.dto.label.LabelDto;
import com.issuetracker.dto.label.LabelListDto;
import com.issuetracker.dto.label.LabelVo;
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

    public Label createLabel(LabelVo labelVo) {
        return labelRepository.save(new Label(labelVo.getLabelName(), labelVo.getBackgroundColor(), labelVo.getFontColor(), labelVo.getDescription()));
    }
}
