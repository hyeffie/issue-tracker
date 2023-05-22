package com.issuetracker.dto.issue;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.data.relational.core.mapping.Column;

@Data
@AllArgsConstructor
public class AssigneeDto {
    private Long id;
    private String userName;
    private String profileUrl;
}
