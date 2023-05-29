//
//  IssueList.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/23.
//

import Foundation
import OrderedCollections

class CompactLabel {
   let labelName: String
   let backgroundColor: String
   
   init(labelName: String, backgroundColor: String) {
      self.labelName = labelName
      self.backgroundColor = backgroundColor
   }
}

class IssueSummary: Hashable {
   let issueId: Int
   var title: String
   let content: String
   var isOpen: Bool
   let milestoneName: String?
   let labelList: [CompactLabel]
   
   init(issueId: Int, title: String, content: String, isOpen: Bool, milestoneName: String?, labelList: [CompactLabel]) {
      self.issueId = issueId
      self.title = title
      self.content = content
      self.isOpen = isOpen
      self.milestoneName = milestoneName
      self.labelList = labelList
   }
   
   static func == (lhs: IssueSummary, rhs: IssueSummary) -> Bool {
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

class IssueList {
   private(set) var issues: OrderedSet<IssueSummary>
//   private(set) var selectedIssues: [IssueSummary] = []
   
   init(issues: [IssueSummary] = []) {
      self.issues = OrderedSet(issues)
   }
   
   private func issue(at index: Int) -> IssueSummary? {
      guard index < issues.count else { return nil }
      return issues[index]
   }
}

extension IssueList {
   enum Notifications {
      static let didAddIssues = Notification.Name(rawValue: "didAddIssues")
      static let didOpenIssue = Notification.Name("didOpenIssue")
      static let didCloseIssue = Notification.Name("didCloseIssue")
      static let didAddFilteredIssues = Notification.Name(rawValue: "didAddFilteredIssues")
   }
   
   enum Keys {
      static let Issues = "Issues"
      static let Issue = "Issue"
   }
}

extension IssueList {
   private func append(_ newIssues: [IssueSummary], _ isFiltered: Bool = false) {
      if isFiltered { self.empty() }
      self.issues.append(contentsOf: newIssues)
      
      let notiName = isFiltered ? Notifications.didAddFilteredIssues : Notifications.didAddIssues
      
      NotificationCenter.default.post(
         name: notiName,
         object: self,
         userInfo: [Keys.Issues: self.issues])
   }
   
   func add(issues: [IssueSummary], isFiltered: Bool = false) {
      self.append(issues, isFiltered)
   }
   
   private func append(_ issue: IssueSummary) {
      self.issues.append(issue)
   }
   
   func add(issue: IssueSummary) {
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

//extension IssueList {
//   private func select(at index: Int) {
//      guard let target = issue(at: index) else { return }
//      guard selectedIssues.contains(target) == false else { return }
//      selectedIssues.append(target)
//   }
//
//   private func deselect(at index: Int) {
//      guard index < issues.count else { return }
//      let target = issues[index]
//      guard let index = selectedIssues.firstIndex(where: { issue in issue == target }) else { return }
//      selectedIssues.remove(at: index)
//   }
//
//   func addSelection(at index: Int) {
//      self.select(at: index)
//   }
//
//   func subSelection(at index: Int) {
//      self.deselect(at: index)
//   }
//
//   func selectAll() {
//      selectedIssues = issues
//   }
//
//   func deselectAll() {
//      selectedIssues = []
//   }
//
//   func openSelectedIssues() {
//      selectedIssues.forEach { target in target.open() }
//   }
//
//   func closeSelectedIssues() {
//      selectedIssues.forEach { target in target.close() }
//   }
//}
