package com.issuetracker.domain;

import java.util.Set;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.MappedCollection;
import org.springframework.data.relational.core.mapping.Table;

import lombok.Data;

@Data
@Table("label")
public class Label {

    public Label(String name, String backgroundColor, String fontColor, String description) {
        this.name = name;
        this.backgroundColor = backgroundColor;
        this.fontColor = fontColor;
        this.description = description;
    }

    @Id
    private Long id;
    private String name;
    @Column("background_color")
    private String backgroundColor;
    @Column("font_color")
    private String fontColor;
    private String description;
}
