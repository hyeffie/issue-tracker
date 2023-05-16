//
//  NetworkError.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/15.
//

import Foundation

enum NetworkError: Error {
  case noResponse
  case invalidData
  case failToParse
}
