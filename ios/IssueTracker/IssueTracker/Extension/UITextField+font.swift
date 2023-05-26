//
//  UITextField+font.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/26.
//

import UIKit

extension UITextField {
   func apply(
      typography: TypoGraphy,
      textColor: Color,
      willApplyHeight: Bool = true)
   {
      self.font = typography.font
      self.textColor = textColor.color
   }
}
