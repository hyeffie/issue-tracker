package com.issuetracker.controller;

import com.issuetracker.dto.label.LabelListDto;
import com.issuetracker.service.LabelService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class LabelController {

    private final LabelService labelService;

    @GetMapping("/api/labels")
    public LabelListDto getLabels() {
        return labelService.findAllLabels();
    }
}
