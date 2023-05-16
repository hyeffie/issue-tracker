//
//  URLSessionDataTaskInterface.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/15.
//

import Foundation

protocol URLSessionDataTaskInterface {
  func resume()
}

extension URLSessionDataTask: URLSessionDataTaskInterface {}

final class MockURLSessionDataTask: URLSessionDataTaskInterface {
  private let resumeHandler: () -> Void
  
  init(resumeHandler: @escaping () -> Void) {
    self.resumeHandler = resumeHandler
  }
  
  func resume() {
    resumeHandler()
  }
}
