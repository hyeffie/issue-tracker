//
//  UITextField+font.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/26.
//

import UIKit

extension UITextField {
   func apply(
      typography: Typography,
      textColor: Color
   ) {
      self.font = typography.font
      self.textColor = textColor.color
   }
}
