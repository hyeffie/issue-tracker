//
//  IssueDetailUseCase.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/26.
//

import Foundation

class IssueDetailUseCase {
   private var detail: IssueDetailDTO?
   private var networkManager: NetworkManager?
   
   init() { }
   
   func loadData(issueId: Int?) {
      guard let id = issueId else {
         return
      }
      
      networkManager = NetworkManager(session: URLSession.shared)
      networkManager?.requestIssueDetail(issueId: id) { [weak self] dto in
         self?.detail = dto
      }
   }
}
