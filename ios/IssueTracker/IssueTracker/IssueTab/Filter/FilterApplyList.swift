//
//  FilterApplyList.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/28.
//

import Foundation

class FilterApplyList {
   private var status: Bool
   private var users: Set<Int>
   private var labels: Set<Int>
   private var milestones: Set<Int>
   
   init(status: Bool = true,
        users: Set<Int> = [],
        labels: Set<Int> = [],
        milestones: Set<Int> = []) {
      
      self.status = status
      self.users = users
      self.labels = labels
      self.milestones = milestones
   }
   
   func addFilter(section: Int, id: Int?) {
      guard let id = id else { return }
      
      switch section {
      case 0:
         break
      case 1:
         self.users.insert(id)
      case 2:
         self.labels.insert(id)
      default:
         self.milestones.insert(id)
      }
   }
}

extension FilterApplyList {
   static let applyFilter = Notification.Name(rawValue: "applyFilter")
}
