//
//  ListingItemFactory.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/24.
//

import Foundation

struct ListingItemFactory {
   struct IssueTab {
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
   
   struct LabelTab {
      private static func makeLabel(with label: LabelListDTO.Label) -> LabelList.Label {
         return .init(labelId: label.id,
                      labelName: label.name,
                      backgroundColor: label.backgroundColor,
                      description: label.description)
      }
      
      static func makeLabelList(with labelList: LabelListDTO) -> [LabelList.Label] {
         let labels = labelList.labelList.map { label in makeLabel(with: label) }
         return labels
      }
   }
   
   struct MilestoneTab {
      private static func makeMilestone(with milestone: MilestoneListDTO.Milestone) -> MilestoneList.Milestone {
         return .init(milestoneId: milestone.milestoneId,
                      name: milestone.name,
                      description: milestone.description,
                      completedAt: milestone.completedAt,
                      countAllOpenedIssues: milestone.countAllOpenedIssues,
                      countAllClosedIssues: milestone.countAllClosedIssues,
                      progress: milestone.progress)
      }
      
      static func makeMilestoneList(with dto: MilestoneListDTO) -> [MilestoneList.Milestone] {
         let milestones = dto.milestoneList.map { milestone in makeMilestone(with: milestone) }
         return milestones
      }
   }
}
