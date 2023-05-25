package com.issuetracker.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import com.issuetracker.domain.Label;
import com.issuetracker.dto.issue.IssueLabelDto;

@Mapper
public interface LabelToDtoMapper {
    LabelToDtoMapper INSTANCE = Mappers.getMapper(LabelToDtoMapper.class);

    @Mapping(source = "id", target = "labelId")
    @Mapping(source = "name", target = "labelName")
    IssueLabelDto toDto(Label label);
}

