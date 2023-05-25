package com.issuetracker.repository;

import org.springframework.data.repository.CrudRepository;

import com.issuetracker.domain.User;

public interface UserRepository extends CrudRepository<User, Long> {

}
