//
//  IssueListDTO.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/15.
//

import Foundation

struct IssueListDTO: Codable {
  struct Issue: Codable {
    struct Label: Codable {
      let title: String
      let color: String
    }
    
    let title: String
    let description: String
    let milestone: String
    let labels: [Label]
  }
  
  let status: Int
  let body: [Issue]
}
