//
//  UILabel+font.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/11.
//

import UIKit

extension UILabel {
   func apply(
      typography: Typography,
      textColor: Color
   ) {
      self.font = typography.font
      self.textColor = textColor.color
   }
}
