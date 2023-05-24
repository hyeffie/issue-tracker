package com.issuetracker.controller;

import com.issuetracker.dto.comment.CommentPostDto;
import com.issuetracker.service.CommentService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequiredArgsConstructor
public class CommentController {

    private final CommentService commentService;

    // TODO: url이 issue/issueId인데 comment controller에 넣을까?
    // TODO: issueId는 query parameter로, writer와 content는 request body로 들어오는데 어떻게 넘겨줄까
    @PostMapping("/api/issues/{issueId}")
    public void post(@RequestBody CommentPostDto commentPostDto, @PathVariable long issueId) {
        commentService.createComment(commentPostDto, issueId);
    }
}
