package com.issuetracker.service;

import com.issuetracker.dto.IssueLabelDto;
import com.issuetracker.repository.LabelRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class LabelService {

    private final LabelRepository labelRepository;

    public List<IssueLabelDto> getIssueLabels() {
        List<IssueLabelDto> tests = labelRepository.getLabels();;

        for (IssueLabelDto test : tests) {

            System.out.println("test = " + test.getLabelId());
        }

        return tests;
    }


}
