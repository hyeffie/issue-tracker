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
      let backgroundColor: String
      let description: String?
      
      init(labelId: Int, labelName: String, backgroundColor: String, description: String?) {
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
