//
//  URLSessionInterface.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/15.
//

import Foundation

protocol URLSessionInterface {
  func dataTask(
    with request: URLRequest,
    handler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void)
  -> URLSessionDataTaskInterface
}

extension URLSession: URLSessionInterface {
  func dataTask(
    with request: URLRequest,
    handler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void)
  -> URLSessionDataTaskInterface
  {
    dataTask(with: request, completionHandler: handler)
  }
}

final class MockURLSession: URLSessionInterface {
  let mockResponse: MockResponse
  
  init(response: MockResponse) {
    self.mockResponse = response
  }
  
  convenience init(withJson jsonName: String) {
    let response = MockResponse(fromJson: jsonName)
    self.init(response: response)
  }
  
  func dataTask(
    with request: URLRequest,
    handler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void)
  -> URLSessionDataTaskInterface
  {
    let resumeHandler = { handler(self.mockResponse.data, self.mockResponse.urlResponse, self.mockResponse.error) }
    return MockURLSessionDataTask(resumeHandler: resumeHandler)
  }
}
