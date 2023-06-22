//
//  LabelListDTO.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/25.
//

import Foundation

struct LabelListDTO: Codable {
   struct Label: Codable {
      let id: Int
      let name: String
      let backgroundColor: String?
      let fontColor: String?
      let description: String
      let deleted: Bool
   }
   
   let labelList: [Label]
   let countAllLabels: Int
}
