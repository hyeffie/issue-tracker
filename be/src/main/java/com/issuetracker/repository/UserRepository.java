package com.issuetracker.repository;

import java.util.List;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import com.issuetracker.domain.User;

public interface UserRepository extends CrudRepository<User, Long> {
    @Query("SELECT id, login_id, profile_url FROM user WHERE id =:userId")
    User findByUserId(long userId);

    /**
     * 유저 필터에 사용할 전체 유저의 목록을 조회합니다.
     */
    @Query("SELECT id, login_id, profile_url FROM user")
    List<User> getFilterUserList();
}
