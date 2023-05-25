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
      var description: String
      var completedAt: Date
      let countAllOpenedIssues: Int
      let countAllClosedIssues: Int
      var progress: Double
      
      init(milestoneId: Int, name: String, description: String, completedAt: Date,
           countAllOpenedIssues: Int, countAllClosedIssues: Int, progress: Double) {
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
