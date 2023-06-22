//
//  IssueFormDTO.swift
//  IssueTracker
//
//  Created by Effie on 2023/06/01.
//

import Foundation

struct IssueFormDTO: Decodable {
   struct User: Decodable {
      let userId: Int
      let userName: String
      let profileUrl: String?
   }
   
   struct Label: Decodable {
      let labelId: Int
      let labelName: String
      let backgroundColor: String
   }
   
   struct Milestone: Decodable {
      let milestoneId: Int
      let milestoneName: String
      let countAllIssues: Int
      let countAllClosedIssues: Int
      let progress: Int
   }
   
   let userId: String
   let profileUrl: String?
   let userList: [User]
   let labelList: [Label]
   let miletoneList: [Milestone]
}
