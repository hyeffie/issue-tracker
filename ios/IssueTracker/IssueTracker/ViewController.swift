//
//  ViewController.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/11.
//

import UIKit

class ViewController: UIViewController {
  
  @IBAction func login(_ sender: Any) {
    let storyboard = UIStoryboard(name: "TabBarController", bundle: nil)
    guard let viewController = storyboard.instantiateInitialViewController() as? UITabBarController else { return }
    let condition = { (scene: UIScene) in scene.activationState == .foregroundActive }
    guard let windowScene = UIApplication.shared.connectedScenes.first(where: condition) as? UIWindowScene,
          let window = windowScene.windows.first(where: { $0.isKeyWindow == true }) else { return }
    window.rootViewController = viewController
  }
}
