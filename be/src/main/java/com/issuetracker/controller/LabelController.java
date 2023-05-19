package com.issuetracker.controller;

import java.sql.SQLException;

import org.springframework.data.relational.core.sql.In;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.issuetracker.domain.Label;
import com.issuetracker.dto.label.LabelListDto;
import com.issuetracker.dto.label.LabelVo;
import com.issuetracker.service.LabelService;

import lombok.RequiredArgsConstructor;

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

    /**
     * 라벨을 ID로 삭제합니다.
     */
    @DeleteMapping("/api/labels/{labelId}")
    public void delete(@PathVariable int labelId) {
        labelService.deleteLabelById(labelId);
    }

    /**
     * 라벨 ID에 해당하는 정보를 업데이트합니다.
     * @param labelId
     * @param labelVo
     */
    @PatchMapping("/api/labels/{labelId}")
    public void update(@PathVariable Integer labelId, @RequestBody LabelVo labelVo) {
        labelService.updateLabel(
                new Label(labelId, labelVo.getLabelName(), labelVo.getBackgroundColor(), labelVo.getFontColor(),
                        labelVo.getDescription(), false));
    }
}
    // @ExceptionHandler(SQLException.class)
    // public void sqlException() {
    //     System.out.println("SQL 예외 발생(예외처리 수정 예정)");
    // }
    //
    // @ExceptionHandler(IllegalArgumentException.class)
    // public void labelException() {
    //     System.out.println("존재하지 않는 Issue입니다.");
    //}

