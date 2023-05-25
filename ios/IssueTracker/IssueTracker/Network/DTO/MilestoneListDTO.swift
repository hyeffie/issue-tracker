//
//  MilestoneDTO.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/25.
//

import Foundation

struct MilestoneListDTO: Codable {
   struct Milestone: Codable, Hashable {
      let milestoneId: Int
      let name: String
      let description: String?
      let completedAt: String?
      let countAllOpenedIssues: Int
      let countAllClosedIssues: Int
      let progress: Int
   }
   
   let milestoneList: [Milestone]
   let countOpenedMilestones: Int
   let countClosedMilestones: Int
}
