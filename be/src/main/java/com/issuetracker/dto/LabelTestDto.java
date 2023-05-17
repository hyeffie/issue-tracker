package com.issuetracker.dto;

import java.util.Set;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.MappedCollection;
import org.springframework.data.relational.core.mapping.Table;

import com.issuetracker.domain.Issue;

import lombok.Data;

@Data
@Table("label")
public class LabelTestDto {
    @Column("labelId")
    private Long id;
    @Column("labelName")
    private String name;
    @Column("backgroundColor")
    private String backgroundColor;
    @Column("fontColor")
    private String fontColor;
    @Column("description")
    private String description;
}
