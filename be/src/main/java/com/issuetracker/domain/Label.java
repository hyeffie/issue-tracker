package com.issuetracker.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import com.issuetracker.dto.label.LabelDto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Table("label")
public class Label {
    @Id
    private Integer id;
    private String name;
    // TODO : Column 빼도 동작하는지 확인
    @Column("background_color")
    private String backgroundColor;
    @Column("font_color")
    private String fontColor;
    private String description;
    private boolean deleted;

    public static Label createUpdateLabel(Integer id, String name, String backgroundColor, String fontColor,
            String description) {
        return new Label(id, name, backgroundColor, fontColor, description, false);
    }

    public static Label createAutoIncrementedLabel(String name, String backgroundColor, String fontColor,
            String description) {
        return new Label(null, name, backgroundColor, fontColor, description, false);
    }

    public static Label ofDeleted(Integer id, String name, String backgroundColor, String fontColor,
            String description) {
        return new Label(id, name, backgroundColor, fontColor, description, true);
    }

    public static Label of(LabelDto labelDto) {
        return new Label(labelDto.getLabelId(), labelDto.getLabelName(), labelDto.getBackgroundColor(),
                labelDto.getFontColor(), labelDto.getDescription(), false);
    }

}
