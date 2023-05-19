//
//  FilterListCollectionViewHeader.swift
//  IssueTracker
//
//  Created by 1 on 2023/05/19.
//

import UIKit

class FilterListCollectionViewHeader: UICollectionReusableView {
   @IBOutlet weak var sectionName: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
   }
   
   func configureFont() {
      self.sectionName.apply(typography: TypoGraphy(weight: .bold, size: .medium),
                             textColor: .gray900)
   }
    
}
