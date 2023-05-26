//
//  LabelCreateEditViewController.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/25.
//

import UIKit

class LabelCreateEditViewController: UITableViewController {
   override func viewDidLoad() {
      super.viewDidLoad()
      self.title = "새로운 레이블"
      self.navigationItem.largeTitleDisplayMode = .never
      self.tableView.separatorInset = .zero
   }
}
