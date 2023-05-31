//
//  IssueCreateViewController.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/31.
//

import UIKit

class IssueCreateViewController: UIViewController, StoryboardBased {
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setNavigationItem()
   }
   
   private func setNavigationItem() {
      self.navigationItem.largeTitleDisplayMode = .never
      let segmentedControl = UISegmentedControl(items: ["마크다운", "미리보기"])
      segmentedControl.selectedSegmentIndex = 0
      self.navigationItem.titleView = segmentedControl
      
      let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: nil)
      saveButton.isEnabled = false
      self.navigationItem.rightBarButtonItem = saveButton
   }
}
