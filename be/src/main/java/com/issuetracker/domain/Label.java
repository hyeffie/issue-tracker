package com.issuetracker.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
@Table("label")
public class Label {
    @Id
    private Integer id;
    private String name;
    private String backgroundColor;
    private String fontColor;
    private String description;
    private boolean deleted;

    public static Label ofUpdated(Integer id, String name, String backgroundColor, String fontColor,
            String description) {
        return new Label(id, name, backgroundColor, fontColor, description, false);
    }

    public static Label ofCreated(String name, String backgroundColor, String fontColor,
            String description) {
        return new Label(null, name, backgroundColor, fontColor, description, false);
    }

    public static Label ofDeleted(Integer id, String name, String backgroundColor, String fontColor,
            String description) {
        return new Label(id, name, backgroundColor, fontColor, description, true);
    }
}
