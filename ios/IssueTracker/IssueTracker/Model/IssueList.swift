//
//  IssueList.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/23.
//

import Foundation

class IssueList {
   class Issue: Hashable {
      class Label {
         let labelName: String
         let backgroundColor: String
         
         init(labelName: String, backgroundColor: String) {
            self.labelName = labelName
            self.backgroundColor = backgroundColor
         }
      }
      
      let issueId: Int
      var title: String
      let content: String
      var isOpen: Bool
      let milestoneName: String?
      let labelList: [Label]
      
      init(issueId: Int, title: String, content: String, isOpen: Bool, milestoneName: String?, labelList: [Label]) {
         self.issueId = issueId
         self.title = title
         self.content = content
         self.isOpen = isOpen
         self.milestoneName = milestoneName
         self.labelList = labelList
      }
      
      static func == (lhs: Issue, rhs: Issue) -> Bool {
         return lhs.issueId == rhs.issueId
      }
      
      func hash(into hasher: inout Hasher) {
         hasher.combine(issueId)
      }
      
      func open() {
         self.isOpen = true
      }
      
      func close() {
         self.isOpen = false
      }
   }
   
   private(set) var issues: [Issue]
   private(set) var selectedIssues: [Issue] = []
   
   init(issues: [Issue] = []) {
      self.issues = issues
   }
   
   private func issue(at index: Int) -> Issue? {
      guard index < issues.count else { return nil }
      return issues[index]
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

extension IssueList {
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
}

extension IssueList {
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

   private func delete(at index: Int) {
      guard index < issues.count else { return }
      issues.remove(at: index)
   }
   
   func deleteIssue(at index: Int) {
      self.delete(at: index)
   }
}

extension IssueList {
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
   
   func openSelectedIssues() {
      selectedIssues.forEach { target in target.open() }
   }
   
   func closeSelectedIssues() {
      selectedIssues.forEach { target in target.close() }
   }
}
