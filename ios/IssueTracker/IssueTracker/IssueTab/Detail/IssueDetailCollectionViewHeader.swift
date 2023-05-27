//
//  IssueDetailCollectionViewHeader.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/24.
//

import UIKit

class IssueDetailCollectionViewHeader: UICollectionReusableView {
   @IBOutlet weak var title: UILabel!
   @IBOutlet weak var number: UILabel!
   /// Wood: 열림/닫힘 여부 표시 Label
   @IBOutlet weak var status: IssueLabel!
   @IBOutlet weak var editTime: UILabel!

   override func awakeFromNib() {
      super.awakeFromNib()
      configureFont()
   }
   
   func configureFont() {
      title.apply(typography: Typography(weight: .bold, size: .xlarge),
                  textColor: .gray900)
      number.apply(typography: Typography(weight: .regular, size: .xlarge),
                   textColor: .gray600)
      status.apply(typography: Typography(weight: .regular, size: .medium),
                   textColor: .gray50)
   }
}
