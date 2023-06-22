package com.issuetracker.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Table("user")
@AllArgsConstructor
@NoArgsConstructor
public class User {
    @Id
    private int id;
    private String loginId;
    private String profileUrl;

    public static User of(String loginId, String avatarUrl) {
        return new User(0, loginId, avatarUrl);
    }
}

