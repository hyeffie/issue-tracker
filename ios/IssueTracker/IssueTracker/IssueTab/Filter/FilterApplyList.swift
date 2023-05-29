//
//  FilterApplyList.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/28.
//

import Foundation

class FilterApplyList {
   var status: Bool
   var users: Set<Int>
   var labels: Set<Int>
   var milestone: Int?
   
   init(status: Bool = true,
        users: Set<Int> = [],
        labels: Set<Int> = [],
        milestone: Int? = nil) {
      
      self.status = status
      self.users = users
      self.labels = labels
      self.milestone = milestone
   }
   
   func addFilter(section: Int, id: Int?) {
      guard let id = id else { return }
      
      switch section {
      case 0:
         self.status = id == 3 ? false : true
      case 1:
         self.users.insert(id)
      case 2:
         self.labels.insert(id)
      default:
         self.milestone = id
      }
   }
   
   func emptyList() {
      self.status = true
      self.users = []
      self.labels = []
      self.milestone = nil
   }
   
   func makeQuery() -> RequestParameters {
      var query: RequestParameters = [:]

      let filterList = self
      let statusString = filterList.status ? "open" : "closed"
      query.updateValue("\(statusString)", forKey: "status")
      
      var userString = ""
      filterList.users.forEach {
         userString += String($0) + ","
      }
      userString = String(userString.dropLast())
      query.updateValue("\(userString)", forKey: "assignee")
      
      var labelString = ""
      filterList.labels.forEach {
         labelString += String($0) + ","
      }
      labelString = String(labelString.dropLast())
      query.updateValue("\(labelString)", forKey: "label")
      
      if let milestoneString = filterList.milestone {
         query.updateValue("\(milestoneString)", forKey: "milestone")
      }
      
      return query
   }
}

extension FilterApplyList {
   static let applyFilter = Notification.Name(rawValue: "applyFilter")
   
   enum Keys {
      static let Filters = "Filters"
   }
}
