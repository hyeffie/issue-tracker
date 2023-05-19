package com.issuetracker.controller;

import com.issuetracker.domain.Label;
import com.issuetracker.dto.label.LabelDto;
import com.issuetracker.dto.label.LabelListDto;
import com.issuetracker.dto.label.LabelVo;
import com.issuetracker.service.LabelService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class LabelController {

    private final LabelService labelService;

    @GetMapping("/api/labels")
    public LabelListDto getLabels() {
        return labelService.findAllLabels();
    }

    @PostMapping("/api/labels")
    public Label createLabel(@RequestBody LabelVo labelVo) {
        return labelService.createLabel(labelVo);
    }
}
