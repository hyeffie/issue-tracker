//
//  LabelDetailPostDTO.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/29.
//

import Foundation

struct LabelDetailPostDTO: Encodable {
   let labelName: String
   let backgroundColor: String
   let fontColor: String
   let description: String
}
