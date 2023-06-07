//
//  SelectToolBar.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/29.
//

import UIKit

class SelectToolBar: UIToolbar {
   @IBOutlet weak var checkBoxItem: UIBarButtonItem!
   @IBOutlet weak var descriptionItem: UIBarButtonItem!
   @IBOutlet weak var closeItem: UIBarButtonItem!
   
   let identifier = "SelectToolBar"
   var countOfSelectedCells = 0
   
   func configureItems(isSelected: Bool = true) {
      
      if isSelected {
         countOfSelectedCells += 1
      } else {
         if countOfSelectedCells > 0 {
            countOfSelectedCells -= 1
         }
      }

      self.descriptionItem.title = "\(countOfSelectedCells)개의 이슈가 선택됨"
      
      guard countOfSelectedCells > 0 else {
         self.checkBoxItem.image = UIImage(systemName: "checkmark.circle")
         return
      }
      self.checkBoxItem.image = UIImage(systemName: "checkmark.circle.fill")
   }
}
