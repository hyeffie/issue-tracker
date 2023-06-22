//
//  ListingItemFactory.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/24.
//

import Foundation

struct ListingItemFactory {
   struct IssueTab {
      private static func makeLabel(with lable: IssueListDTO.Label) -> CompactLabel {
         return .init(labelName: lable.labelName,
                      backgroundColor: lable.backgroundColor)
      }
      
      private static func makeIssue(with issue: IssueListDTO.Issue) -> IssueSummary {
         let labelList = issue.labelList.map { label in makeLabel(with: label) }
         return .init(issueId: issue.issueId,
                      title: issue.title,
                      content: issue.content,
                      isOpen: issue.open,
                      milestoneName: issue.milestoneName,
                      labelList: labelList)
      }
      
      static func makeIssues(with issues: [IssueListDTO.Issue]) -> [IssueSummary] {
         return issues.map { issue in makeIssue(with: issue) }
      }
      
      static func makeIssueList(with issueList: IssueListDTO) -> IssueList {
         let issues = makeIssues(with: issueList.issues)
         return IssueList(issues: issues)
      }
      
      static func makeIssueFormData(with issueListDTO: IssueListDTO) -> IssueFormData {
         let users = issueListDTO.userList.map { user in IssueFormData.User(userId: user.userId, userName: user.userName) }
         let labels = issueListDTO.labelList.map { label in
            IssueFormData.Label(labelId: label.labelId, labelName: label.labelName)
         }
         let milestones = issueListDTO.milestoneList.map { milestone in
            IssueFormData.Milestone(milestoneId: milestone.milestoneId, milestoneName: milestone.milestoneName ?? "이름 없음")
         }
         return IssueFormData(userList: users, labelList: labels, miletoneList: milestones)
      }
      
      static func makeIssueDetailPostDTO(with issueDetailDTO: IssueDetailDTO) -> IssueDetailPostDTO {
         let userId = issueDetailDTO.userList.first(where: { user in user.userName == issueDetailDTO.issue.userName })?.userId ?? 1
         let title = issueDetailDTO.issue.title
         let content = issueDetailDTO.issue.content
         let imgUrl: String? = nil
         let userList = issueDetailDTO.attachedAssigneeList.map { assignee in
            IssueDetailPostDTO.User(userId: assignee.id)
         }
         let labelList = issueDetailDTO.attachedLabelList.map { label in
            IssueDetailPostDTO.Label(labelId: label.labelId)
         }
         let milestoneId = issueDetailDTO.attachedMilestone?.milestoneId
         return IssueDetailPostDTO(userId: userId, title: title, content: content, imgUrl: imgUrl, userList: userList, labelList: labelList, milestoneId: milestoneId)
      }

   }
   
   struct LabelTab {
      private static func makeLabel(with label: LabelListDTO.Label) -> LabelDetail {
         return .init(labelId: label.id,
                      labelName: label.name,
                      backgroundColor: label.backgroundColor,
                      description: label.description)
      }
      
      static func makeLabelList(with labelList: LabelListDTO) -> [LabelDetail] {
         let labels = labelList.labelList.map { label in makeLabel(with: label) }
         return labels
      }
   }
   
   struct MilestoneTab {
      private static func makeMilestone(with milestone: MilestoneListDTO.Milestone) -> MilestoneDetail {
         return .init(milestoneId: milestone.milestoneId,
                      name: milestone.name,
                      description: milestone.description,
                      completedAt: milestone.completedAt,
                      countAllOpenedIssues: milestone.countAllOpenedIssues,
                      countAllClosedIssues: milestone.countAllClosedIssues,
                      progress: milestone.progress)
      }
      
      static func makeMilestoneList(with dto: MilestoneListDTO) -> [MilestoneDetail] {
         let milestones = dto.milestoneList.map { milestone in makeMilestone(with: milestone) }
         return milestones
      }
   }
}
