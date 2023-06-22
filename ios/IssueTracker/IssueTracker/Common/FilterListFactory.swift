//
//  FilterListFactory.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/28.
//

import Foundation

struct FilterListFactory {
   static func make(issueList: IssueListDTO) -> IssueFilterList {
      return IssueFilterList(userList: issueList.userList,
                             labelList: issueList.labelList,
                             milestoneList: issueList.milestoneList)
   }
}
