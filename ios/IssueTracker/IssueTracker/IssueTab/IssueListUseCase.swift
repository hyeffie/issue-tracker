//
//  IssueListUseCase.swift
//  IssueTracker
//
//  Created by 1 on 2023/05/18.
//

import Foundation

class IssueListUseCase {
   let issues: [Issue]
   let users: [User]
   let labels: [Label]
   let milestones: [Milestone]
   
   init(issues: [Issue], users: [User], labels: [Label], milestones: [Milestone]) {
      self.issues = issues
      self.users = users
      self.labels = labels
      self.milestones = milestones
   }
}
