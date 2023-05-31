//
//  ServerAPI.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/31.
//

import Foundation

class ServerAPI {
   static var baseURL = {
      guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
         fatalError("Couldn't find file 'Property List.plist'.")
      }
      
      // .plist를 딕셔너리로 받아오기
      let plist = NSDictionary(contentsOfFile: filePath)
      
      // 딕셔너리에서 값 찾기
      
      guard let value = plist?.object(forKey: "baseURL") as? String else {
         fatalError("Couldn't find key 'baseURL' in 'KeyList.plist'.")
      }
      
      let firstIndex = value.index(value.startIndex, offsetBy: 1)
      let endIndex = value.index(value.endIndex, offsetBy: -2)
      return String(value[firstIndex...endIndex])
   }()
   
   static var issueURL = {
      return "\(baseURL)/issues"
   }()
   
   static var labelURL = {
      return "\(baseURL)/labels"
   }()
   
   static var milestoneURL = {
      return "\(baseURL)/milestones"
   }()
   
   static func getBaseURL() -> String {
      guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
         fatalError("Couldn't find file 'Property List.plist'.")
      }
      
      // .plist를 딕셔너리로 받아오기
      let plist = NSDictionary(contentsOfFile: filePath)
      
      // 딕셔너리에서 값 찾기
      
      guard let value = plist?.object(forKey: "baseURL") as? String else {
         fatalError("Couldn't find key 'baseURL' in 'KeyList.plist'.")
      }
      
      let firstIndex = value.index(value.startIndex, offsetBy: 1)
      let endIndex = value.index(value.endIndex, offsetBy: -2)
      
      return String(value[firstIndex...endIndex])
   }
}
