package com.issuetracker.mapper;

import com.issuetracker.domain.IssueListPage;
import com.issuetracker.dto.issueList.FilterDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IssueListMapper {
    List<IssueListPage> findIssueList(FilterDto filterDto);
}
