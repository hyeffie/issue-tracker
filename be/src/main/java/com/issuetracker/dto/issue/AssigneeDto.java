package com.issuetracker.dto.issue;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.data.relational.core.mapping.Column;

@Data
@AllArgsConstructor
public class AssigneeDto {
    private Long id;
    @Column("login_id")
    private String userName;
    @Column("profile_url")
    private String profileUrl;
}
