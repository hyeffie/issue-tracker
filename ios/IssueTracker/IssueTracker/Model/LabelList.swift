//
//  LabelList.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/25.
//

import Foundation
import OrderedCollections

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
      hasher.combine(labelName)
      hasher.combine(backgroundColor)
      hasher.combine(description)
   }
   
   static func == (lhs: LabelDetail, rhs: LabelDetail) -> Bool {
      return lhs.labelId == rhs.labelId
   }
}

class LabelList {
   private(set) var labels: OrderedSet<LabelDetail>
   
   init(labels: [LabelDetail] = []) {
      self.labels = OrderedSet(labels)
   }
}

extension LabelList {
   enum Notifications {
      static let didAddLabels = Notification.Name(rawValue: "didAddLabels")
      static let didAddLabel = Notification.Name(rawValue: "didAddLabel")
      static let didEditLabel = Notification.Name(rawValue: "didEditLabel")
      static let didDeleteLabel = Notification.Name(rawValue: "didEditLabel")
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

extension LabelList {
   func getLabelId(of index: Int) -> Int? {
      guard index < labels.count else { return nil }
      return labels[index].labelId
   }
   
   private func getIndexOfLabel(withId id: Int) -> Int? {
      self.labels.firstIndex(where: { label in label.labelId == id })
   }
   
   private func remove(at index: Int) {
      self.labels.remove(at: index)
      
      NotificationCenter.default.post(
         name: Notifications.didDeleteLabel,
         object: self)
   }
   
   func deleteLabel(id: Int) {
      guard let index = self.getIndexOfLabel(withId: id) else { return }
      remove(at: index)
   }
}
