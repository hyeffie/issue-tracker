//
//  LabelList.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/25.
//

import Foundation

class LabelDetail: Hashable {
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
   
   static func == (lhs: LabelDetail, rhs: LabelDetail) -> Bool {
      return lhs.labelId == rhs.labelId
   }
}

class LabelList {
   private(set) var labels: [LabelDetail]
   
   init(labels: [LabelDetail] = []) {
      self.labels = labels
   }
}

extension LabelList {
   enum Notifications {
      static let didAddLabels = Notification.Name(rawValue: "didAddLabels")
      static let didAddLabel = Notification.Name(rawValue: "didAddLabel")
   }
   
   enum Keys {
      static let Labels = "Labels"
      static let Label = "Label"
   }
}

extension LabelList {
   private func append(_ newLabels: [LabelDetail]) {
      self.labels.append(contentsOf: newLabels)
      
      NotificationCenter.default.post(
         name: Notifications.didAddLabels,
         object: self,
         userInfo: [:])
   }
   
   func add(labels: [LabelDetail]) {
      self.append(labels)
   }
   
   private func empty() {
      self.labels = []
   }
   
   func emptyList() {
      self.empty()
   }
}

extension LabelList {   
   func getLabelDetail(of index: Int) -> LabelDetail? {
      guard index < labels.count else { return nil }
      return labels[index]
   }
}
