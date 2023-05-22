//
//  UILabel+font.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/11.
//

import UIKit

extension UILabel {
   func apply(
      typography: TypoGraphy,
      textColor: Color,
      willApplyHeight: Bool = true)
   {
      self.font = typography.font
      self.textColor = textColor.color
   }
}
