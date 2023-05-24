package com.issuetracker.repository;

import com.issuetracker.domain.Comment;
import org.springframework.data.repository.CrudRepository;

public interface CommentRepository extends CrudRepository<Comment, Long> {

    
}
