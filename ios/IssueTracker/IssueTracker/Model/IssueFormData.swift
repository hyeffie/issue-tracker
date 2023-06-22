//
//  IssueFormData.swift
//  IssueTracker
//
//  Created by Effie on 2023/06/01.
//

import Foundation

class IssueFormData {
   class User {
      let userId: Int
      let userName: String
      
      init(userId: Int, userName: String) {
         self.userId = userId
         self.userName = userName
      }
   }
   
   class Label {
      let labelId: Int
      let labelName: String
      
      init(labelId: Int, labelName: String) {
         self.labelId = labelId
         self.labelName = labelName
      }
   }
   
   class Milestone {
      let milestoneId: Int
      let milestoneName: String
      
      init(milestoneId: Int, milestoneName: String) {
         self.milestoneId = milestoneId
         self.milestoneName = milestoneName
      }
   }
   
   let userList: [User]
   let labelList: [Label]
   let miletoneList: [Milestone]
   
   init(userList: [User], labelList: [Label], miletoneList: [Milestone]) {
      self.userList = userList
      self.labelList = labelList
      self.miletoneList = miletoneList
   }
}
