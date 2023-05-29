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
   
   func initSubviews() {
      guard let viewFromNib = Bundle.main.loadNibNamed(identifier,
                                                       owner: self)?.first as? UIToolbar else {
         return
      }

      viewFromNib.frame = bounds
      viewFromNib.autoresizingMask = [.flexibleWidth, .flexibleHeight]

      addSubview(viewFromNib)
   }
   
   func configureItems(issueCount: Int) {
      self.descriptionItem.title = "\(issueCount)개의 이슈가 선택됨"
      
      guard issueCount > 0 else {
         return
      }
      self.checkBoxItem.image = UIImage(systemName: "checkmark.circle.fill")
   }
}
