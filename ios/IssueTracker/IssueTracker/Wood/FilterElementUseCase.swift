//
//  FilterElement.swift
//  IssueTracker
//
//  Created by 1 on 2023/05/18.
//

import Foundation

class FilterElementUseCase {
   let users: [User]
   let labels: [Label]
   let milestones: [Milestone]
   
   init(users: [User], labels: [Label], milestones: [Milestone]) {
      self.users = users
      self.labels = labels
      self.milestones = milestones
   }
}
