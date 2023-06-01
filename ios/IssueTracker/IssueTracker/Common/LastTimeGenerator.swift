//
//  LastTimeGenerator.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/25.
//

import Foundation

struct LastTimeGenerator {
   static let dateFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzzz"
      formatter.locale = Locale(identifier: "ko_KR")
      return formatter
   }()
   
   static let dateComponent: DateComponents = {
      var component = DateComponents()
      component.hour = 9
      return component
   }()
   
   static func calculateLastTime(past: String) -> String {
      guard let pastTime = dateFormatter.date(from: past + " +0000"),
            let now = Calendar.current.date(byAdding: dateComponent, to: Date()) else {
         return ""
      }
      
      var lastTime = Int(now.timeIntervalSince(pastTime)) / 60
      guard lastTime > 60 else {
         let time = Int(lastTime) % 60
         return "\(time)분"
      }
      
      lastTime /= 60
      guard lastTime > 24 else {
         let time = Int(lastTime) % 60
         return "\(time)시간"
      }
      
      return "\(lastTime)일"
   }
}
