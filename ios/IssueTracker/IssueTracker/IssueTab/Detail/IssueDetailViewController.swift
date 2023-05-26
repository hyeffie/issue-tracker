//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/26.
//

import UIKit

class IssueDetailViewController: UIViewController {
   override func viewDidLoad() {
      super.viewDidLoad()
      hideTabBar()
      addEditButton()
   }
   
   private func addEditButton() {
      guard let editImage = UIImage(systemName: "ellipsis") else { return }
      let editButton = UIBarButtonItem(image: editImage)
      self.navigationItem.rightBarButtonItem = editButton
   }
}
