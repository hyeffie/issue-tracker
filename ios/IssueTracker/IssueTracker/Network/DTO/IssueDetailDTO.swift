//
//  IssueDetailDTO.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/25.
//

import Foundation

/// Wood: API 응답이 달라 Issue, Milestone 등 기존 DTO를  재사용하지 못 하고 새로 선언
struct IssueDetailDTO: Codable {
   struct Issue: Codable {
      let issueId: Int
      var title: String
      let content: String
      let userName: String
      let profileUrl: String?
      let createdAt: String
      let closedAt: String?
      let open: Bool
   }
   
   struct Milestone: Codable {
      let milestoneId: Int
      let milestoneName: String
      let countAllIssues: Int
      let countAllClosedIssues: Int
      let progress: Int
   }
   
   struct Label: Codable {
      let labelId: Int
      let labelName: String
      let backgroundColor: String
      let fontColor: String
   }
   
   struct Assignee: Codable {
      let userid: Int
      let userName: String
      let profileUrl: String
   }
   
   struct Comment: Codable {
      let commentId: Int
      let userId: Int
      let userName: String
      let profileUrl: String
      let content: String
      let createdAt: String
      let updateAt: String
   }
   
   let issue: Issue
   let attachedMilestone: Milestone
   let attachedLabelList: [Label]
   let attachedAssigneeList: [Assignee]
   let commentList: [Comment]
   let userList: [IssueListDTO.User]
   let labelList: [IssueListDTO.Label]
   let milestoneList: [IssueListDTO.Milestone]
}

extension IssueDetailDTO {
   enum Notifications {
      static let didLoadDetail = Notification.Name(rawValue: "didLoadDetails")
   }
}
