//
//  IssueDetailHeaderData.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/26.
//

import Foundation

struct IssueDetailHeaderData {
   let title: String
   let number: Int
   let status: Bool
   let userName: String
   let editTime: String
   
   init(title: String = "",
        number: Int = 0,
        status: Bool = true,
        userName: String = "",
        editTime: String = "") {
      
      self.title = title
      self.number = number
      self.status = status
      self.userName = userName
      self.editTime = editTime
   }
}
