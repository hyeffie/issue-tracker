package com.issuetracker.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.issuetracker.dto.issueList.Filter;

@Mapper
public interface IssueIdListMapper {
    List<Long> findIssueIdList(Filter filterDto);
}
