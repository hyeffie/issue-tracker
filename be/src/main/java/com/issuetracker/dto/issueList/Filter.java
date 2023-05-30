package com.issuetracker.dto.issueList;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Filter {
    private String status;
    private List<Long> assignee;
    private List<Integer> label;
    private Integer milestone;
    private Long writer;
    private Integer pageNum;
    private String search;

    public boolean getOpenStatus() {

        if (status != null && status.equals("close")) {
            return false;
        }
        return true;
    }

    public int getOffset() {
        if (pageNum != null) {
            return (pageNum - 1) * 10;
        }
        return 0;
    }

    public int getAssigneeSize() {
        return assignee.size();
    }
}
