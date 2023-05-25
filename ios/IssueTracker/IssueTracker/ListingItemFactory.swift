//
//  ListingItemFactory.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/24.
//

import Foundation

struct ListingItemFactory {
   struct LabelList {
      private static func makeLabel(with lable: IssueListDTO.Label) -> IssueList.Issue.Label {
         return .init(labelName: lable.labelName,
                      backgroundColor: lable.backgroundColor)
      }
      
      private static func makeIssue(with issue: IssueListDTO.Issue) -> IssueList.Issue {
         let labelList = issue.labelList.map { label in makeLabel(with: label) }
         return .init(issueId: issue.issueId,
                      title: issue.title,
                      content: issue.content,
                      isOpen: issue.open,
                      milestoneName: issue.milestoneName,
                      labelList: labelList)
      }
      
      static func makeIssues(with issues: [IssueListDTO.Issue]) -> [IssueList.Issue] {
         return issues.map { issue in makeIssue(with: issue) }
      }
      
      static func makeIssueList(with issueList: IssueListDTO) -> IssueList {
         let issues = makeIssues(with: issueList.issues)
         return IssueList(issues: issues)
      }
   }
}
