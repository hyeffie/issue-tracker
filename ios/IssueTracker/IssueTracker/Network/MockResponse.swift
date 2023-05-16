//
//  Response.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/16.
//

import Foundation

struct MockResponse {
  let data: Data?
  let urlResponse: URLResponse?
  let error: Error?
  
  init(fromJson jsonFileName: String) {
    let fileName = jsonFileName
    let json = ".json"
    let path = Bundle.main.path(forResource: fileName, ofType: json) ?? ""
    let fileURL = URL(filePath: path)
    let mockData: Data? = try? Data(contentsOf: fileURL)
    
    let dummyURL = URL(string: "https://api.codesquad.kr/onban/main")!
    let response = HTTPURLResponse(
      url: dummyURL,
      statusCode: 200,
      httpVersion: nil,
      headerFields: [:])
    
    let error: Error? = nil
    
    self.data = mockData
    self.urlResponse = response
    self.error = error
  }
}
