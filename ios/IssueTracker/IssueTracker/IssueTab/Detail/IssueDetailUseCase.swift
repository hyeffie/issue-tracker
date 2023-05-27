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
      
      NotificationCenter.default.post(name: IssueDetailDTO.Notifications.didLoadDetail,
                                      object: nil)
   }
   
   func sendHeaderData() -> IssueDetailHeaderData {
      guard let data = self.detail?.issue else {
         return IssueDetailHeaderData()
      }
      
      var time = data.createdAt
      if !data.open, let closedAt = data.closedAt {
         time = closedAt
      }

      return IssueDetailHeaderData(title: data.title,
                                   number: data.issueId,
                                   status: data.open,
                                   userName: data.userName,
                                   editTime: time)
   }
}
