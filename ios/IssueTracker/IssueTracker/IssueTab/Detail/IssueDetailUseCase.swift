//
//  IssueDetailUseCase.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/26.
//

import UIKit

class IssueDetailUseCase {
   private var detail: IssueDetailDTO?
   private var networkManager: NetworkManager?
   
   var commentCount: Int {
      get { return detail?.commentList.count ?? 0 }
   }
   
   init() { }
   
   func loadData(issueId: Int?) {
      guard let id = issueId else {
         return
      }
      
      networkManager = NetworkManager(session: URLSession.shared)
      networkManager?.requestIssueDetail(issueId: id) { [weak self] dto in
         self?.detail = dto
         NotificationCenter.default.post(name: IssueDetailDTO.Notifications.didLoadDetail,
                                         object: nil)
      }
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
   
   func sendComent(row: Int) -> IssueDetailDTO.Comment? {
      guard let comment = self.detail?.commentList[row-1] else {
         return nil
      }
      
      return comment
   }
   
   func sendImage(row: Int) async -> Data? {
      guard let profileUrl = self.detail?.commentList[row].profileUrl,
            let imageUrl = URL(string: profileUrl) else {
         return nil
      }
      
      var imageData: Data? = nil
      do {
         imageData = try Data(contentsOf: imageUrl)
      } catch let error {
         print(error)
      }
      
      return imageData
   }
}

extension IssueDetailUseCase {
   static let didLoadDetailData = Notification.Name(rawValue: "didLoadDetailData")
}
