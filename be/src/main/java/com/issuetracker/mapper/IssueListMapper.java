package com.issuetracker.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.issuetracker.domain.IssueListPage;

@Mapper
public interface IssueListMapper {
    List<IssueListPage> findIssueList(List<Long> filteredIssueIdList);
}
