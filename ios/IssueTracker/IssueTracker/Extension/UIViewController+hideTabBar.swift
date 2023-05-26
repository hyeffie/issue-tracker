//
//  UIViewController+hideTabBar.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/26.
//

import UIKit

extension UIViewController {
   /// Wood: Using for Issue Detail Page & Issue choosing Page
   func hideTabBar() {
      self.tabBarController?.tabBar.isHidden = true
   }
}
