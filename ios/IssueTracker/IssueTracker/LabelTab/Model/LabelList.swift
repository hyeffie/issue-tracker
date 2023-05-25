//
//  LabelList.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/25.
//

import Foundation

class LabelList {
   class Label: Hashable {
      let labelId: Int
      let labelName: String
      let backgroundColor: String?
      let description: String?
      
      init(labelId: Int, labelName: String, backgroundColor: String?, description: String?) {
         self.labelId = labelId
         self.labelName = labelName
         self.backgroundColor = backgroundColor
         self.description = description
      }
      
      func hash(into hasher: inout Hasher) {
         hasher.combine(labelId)
      }
      
      static func == (lhs: LabelList.Label, rhs: LabelList.Label) -> Bool {
         return lhs.labelId == rhs.labelId
      }
   }
   
   private(set) var labels: [Label]
   
   init(labels: [Label] = []) {
      self.labels = labels
   }
}

extension LabelList {
   enum Notifications {
      static let didAddLabels = Notification.Name(rawValue: "didAddLabels")
   }
   
   enum Keys {
      static let Labels = "Labels"
   }
}

extension LabelList {
   private func append(_ newLabels: [Label]) {
      self.labels.append(contentsOf: newLabels)
      
      NotificationCenter.default.post(
         name: Notifications.didAddLabels,
         object: self,
         userInfo: [:])
   }
   
   func add(labels: [Label]) {
      self.append(labels)
   }
   
   private func empty() {
      self.labels = []
   }
   
   func emptyList() {
      self.empty()
   }
}
