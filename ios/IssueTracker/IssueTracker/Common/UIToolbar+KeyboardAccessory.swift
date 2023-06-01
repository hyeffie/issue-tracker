//
//  UIToolbar+KeyboardAccessory.swift
//  IssueTracker
//
//  Created by Effie on 2023/06/01.
//

import UIKit

extension UIToolbar {
   static func makeDoneButtonToolBar(action: @escaping UIActionHandler) -> UIToolbar {
      let keyboardToolBar = UIToolbar()
      keyboardToolBar.sizeToFit()
      let flexibleItem = UIBarButtonItem(systemItem: .flexibleSpace)
      let doneAction = UIAction(handler: action)
      let doneButton = UIBarButtonItem(systemItem: .done, primaryAction: doneAction)
      // UIBarButtonItem(title: "Done", style: .done, target: self, action: action)
      keyboardToolBar.items = [flexibleItem, doneButton]
      return keyboardToolBar
   }
}
