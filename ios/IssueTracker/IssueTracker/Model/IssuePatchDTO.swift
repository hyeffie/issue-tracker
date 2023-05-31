//
//  IssuePatchDTO.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/31.
//

import Foundation

class IssuePatchDTO: Encodable {
   struct Issue: Encodable {
      var issueId: Int
      var opened: Bool
      
      init(issueId: Int, opened: Bool = false) {
         self.issueId = issueId
         self.opened = opened
      }
   }
   
   var issues: [Issue]
   
   init(issues: [Issue] = []) {
      self.issues = issues
   }
   
   func add(issue: Issue) {
      self.issues.append(issue)
   }
   
   func remove(id: Int) {
      self.issues.removeAll(where: { $0.issueId == id })
   }
   
   func emptyList() {
      self.issues = []
   }
   
   func sendIds() -> [Int] {
      var ids: [Int] = []
      self.issues.forEach { ids.append($0.issueId) }
      return ids
   }
}
