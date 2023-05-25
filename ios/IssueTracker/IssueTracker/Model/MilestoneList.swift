//
//  MilestoneList.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/25.
//

import Foundation

class MilestoneList {
   class Milestone: Hashable {
      let milestoneId: Int
      var name: String
      var description: String?
      var completedAt: String?
      let countAllOpenedIssues: Int
      let countAllClosedIssues: Int
      var progress: Int
      
      init(milestoneId: Int, name: String, description: String?, completedAt: String?,
           countAllOpenedIssues: Int, countAllClosedIssues: Int, progress: Int) {
         self.milestoneId = milestoneId
         self.name = name
         self.description = description
         self.completedAt = completedAt
         self.countAllOpenedIssues = countAllOpenedIssues
         self.countAllClosedIssues = countAllClosedIssues
         self.progress = progress
      }
      
      func hash(into hasher: inout Hasher) {
         hasher.combine(milestoneId)
      }
      
      static func == (lhs: MilestoneList.Milestone, rhs: MilestoneList.Milestone) -> Bool {
         lhs.milestoneId == rhs.milestoneId
      }
   }
   
   private(set) var milestones: [Milestone]
   
   init(milestones: [Milestone] = []) {
      self.milestones = milestones
   }
}

extension MilestoneList {
   enum Notifications {
      static let didAddMilestones = Notification.Name(rawValue: "didAddMilestones")
   }
}

extension MilestoneList {
   private func append(_ newMilestones: [Milestone]) {
      self.milestones.append(contentsOf: newMilestones)
      
      NotificationCenter.default.post(
         name: Notifications.didAddMilestones,
         object: self,
         userInfo: [:])
   }
   
   func add(milestones: [Milestone]) {
      self.append(milestones)
   }
   
   private func empty() {
      self.milestones = []
   }
   
   func emptyList() {
      self.empty()
   }
}
