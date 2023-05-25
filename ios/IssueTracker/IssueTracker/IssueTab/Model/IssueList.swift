//
//  IssueList.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/23.
//

import Foundation

class IssueList {
   typealias Issue = IssueListDTO.Issue
   
   private(set) var issues: [Issue]
   private(set) var selectedIssues: [Issue] = []
   
   init(issues: [Issue] = []) {
      self.issues = issues
   }
   
   private func issue(at index: Int) -> Issue? {
      guard index < issues.count else { return nil }
      return issues[index]
   }
   
   private func append(_ newIssues: [Issue]) {
      self.issues.append(contentsOf: newIssues)
      
      NotificationCenter.default.post(
         name: Notifications.didAddIssues,
         object: self,
         userInfo: [Keys.Issues: self.issues])
   }
   
   func add(issues: [Issue]) {
      self.append(issues)
   }
   
   private func append(_ issue: Issue) {
      self.issues.append(issue)
   }
   
   func add(issue: Issue) {
      self.append(issue)
   }
   
   private func empty() {
      self.issues = []
   }
   
   func emptyList() {
      self.empty()
   }
   
   private func select(at index: Int) {
      guard let target = issue(at: index) else { return }
      guard selectedIssues.contains(target) == false else { return }
      selectedIssues.append(target)
   }
   
   private func deselect(at index: Int) {
      guard index < issues.count else { return }
      let target = issues[index]
      guard let index = selectedIssues.firstIndex(where: { issue in issue == target }) else { return }
      selectedIssues.remove(at: index)
   }
   
   func addSelection(at index: Int) {
      self.select(at: index)
   }
   
   func subSelection(at index: Int) {
      self.deselect(at: index)
   }
   
   func selectAll() {
      selectedIssues = issues
   }
   
   func deselectAll() {
      selectedIssues = []
   }
   
   private func open(at index: Int) {
      guard let target = issue(at: index) else { return }
      target.open()
   }
   
   func openIssue(at index: Int) {
      self.open(at: index)
   }
   
   private func close(at index: Int) {
      guard let target = issue(at: index) else { return }
      target.close()
   }
   
   func closeIssue(at index: Int) {
      close(at: index)
   }
   
   func openSelectedIssues() {
      selectedIssues.forEach { target in target.open() }
   }
   
   func closeSelectedIssues() {
      selectedIssues.forEach { target in target.close() }
   }
   
   private func delete(at index: Int) {
      guard index < issues.count else { return }
      issues.remove(at: index)
   }
   
   func deleteIssue(at index: Int) {
      self.delete(at: index)
   }
}

extension IssueList {
   enum Notifications {
      static let didAddIssues = Notification.Name(rawValue: "didAddIssues")
      static let didOpenIssue = Notification.Name("didOpenIssue")
      static let didCloseIssue = Notification.Name("didCloseIssue")
   }
   
   enum Keys {
      static let Issues = "Issues"
      static let Issue = "Issue"
   }
}
