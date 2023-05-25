//
//  TabBarController.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/14.
//

import UIKit

class TabBarController: UITabBarController {
   override func viewDidLoad() {
      super.viewDidLoad()
      setViewControllers()
   }
   
   func setViewControllers() {
      let issueListStoryBoard = UIStoryboard(name: "IssueList", bundle: nil)
      guard let issueListController = issueListStoryBoard.instantiateInitialViewController() as? UINavigationController else { return }
      
      let labelListVC = LabelListViewController()
      labelListVC.view.backgroundColor = .systemBackground
      let labelNavigationController = UINavigationController(rootViewController: labelListVC)
      labelNavigationController.navigationBar.prefersLargeTitles = true
      labelNavigationController.tabBarItem.title = "레이블"
      labelNavigationController.tabBarItem.image = UIImage(named: "tag")
      
      let controllers = [issueListController, labelNavigationController]
      setViewControllers(controllers, animated: false)
   }
}
