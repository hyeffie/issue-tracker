package com.issuetracker.mapper;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.issuetracker.domain.Label;
import com.issuetracker.dto.issue.IssueLabelDto;

public class LabelToDtoMapper {
    private static final ObjectMapper objectMapper = new ObjectMapper();

    public static IssueLabelDto toDto(Label label) {
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        try {
            String jsonString = objectMapper.writeValueAsString(label);
            jsonString = jsonString.replace("id", "labelId").replace("name", "labelName");
            return objectMapper.readValue(jsonString, IssueLabelDto.class);
        } catch (JsonProcessingException e) {
            throw new IllegalArgumentException("Json Parse Error");
        }
    }
}

