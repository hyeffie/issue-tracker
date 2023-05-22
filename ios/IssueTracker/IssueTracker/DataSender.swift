//
//  DataSender.swift
//  IssueTracker
//
//  Created by 1 on 2023/05/18.
//

import Foundation

protocol DataSenderDelegate {
   func receive() -> IssueListDTO
}
