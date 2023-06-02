//
//  IssueDetailPostDTO.swift
//  IssueTracker
//
//  Created by Effie on 2023/06/01.
//

import Foundation

struct IssueDetailPostDTO: Encodable {
   struct User: Encodable {
      let userId: Int
   }
   
   struct Label: Encodable {
      let labelId: Int
   }
   
   private(set) var userId: Int
   private(set) var title: String
   private(set) var content: String
   private(set) var imgUrl: String? // 확실히 optional?
   
   private(set) var userList: [User]
   private(set) var labelList: [Label]
   private(set) var milestoneId: Int? // optional?
   
   mutating func replaceAssigneeList(_ newAssignee: Set<Int>) {
      let array = newAssignee.getSortedArray()
      userList = array.map { id in User(userId: id) }
   }
   
   mutating func replaceLabelList(_ newLabel: Set<Int>) {
      let array = newLabel.getSortedArray()
      labelList = array.map { id in Label(labelId: id) }
   }
   
   mutating func replaceMilestone(_ newMilestone: Int?) {
      milestoneId = newMilestone
   }
   
   mutating func replaceData(userId: Int, title: String, content: String) {
      self.userId = userId
      self.title = title
      self.content = content
   }
   
   // TODO: image url
}

extension Set where Element: Comparable {
   func getSortedArray() -> [Element] {
      let array = Array(self)
      return array.sorted()
   }
}
