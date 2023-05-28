//
//  IssueFilterList.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/28.
//

import Foundation

struct IssueFilterList {
   var headerList: [String]
   var statusList: [String]
   var userList: [IssueListDTO.User]
   var labelList: [IssueListDTO.Label]
   var milestoneList: [IssueListDTO.Milestone]
   
   init(headerList: [String] = ["상태", "담당자", "레이블", "마일스톤"],
        statusList: [String] = ["열린 이슈", "내가 작성한 이슈", "내가 댓글을 남긴 이슈", "닫힌 이슈"],
        userList: [IssueListDTO.User] = [],
        labelList: [IssueListDTO.Label] = [],
        milestoneList: [IssueListDTO.Milestone] = []) {
      self.headerList = headerList
      self.statusList = statusList
      self.userList = userList
      self.labelList = labelList
      self.milestoneList = milestoneList
   }
}
