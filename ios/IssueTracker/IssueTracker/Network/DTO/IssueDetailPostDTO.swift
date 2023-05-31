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
   
   let title: String
   let content: String
   let imgUrl: String? // 확실히 optional?
   let userId: Int
   
   var userList: [User]
   var labelList: [Label]
   var milestoneId: Int // optional?
   
   mutating func replaceAssigneeList(_ newAssignee: Set<Int>) {
      let array = newAssignee.getSortedArray()
      userList = array.map { id in User(userId: id) }
   }
}

extension Set where Element: Comparable {
   func getSortedArray() -> [Element] {
      let array = Array(self)
      return array.sorted()
   }
}
