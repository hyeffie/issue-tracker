package com.issuetracker.service;

import com.issuetracker.domain.Comment;
import com.issuetracker.dto.comment.CommentPostDto;
import com.issuetracker.repository.CommentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@Service
@RequiredArgsConstructor
public class CommentService {

    private final CommentRepository commentRepository;

    public void createComment(CommentPostDto commentPostDto, long issueId) {
        commentRepository.save(Comment.createComment(commentPostDto, issueId));
    }
}
