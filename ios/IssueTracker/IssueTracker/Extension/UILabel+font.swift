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
    textColor: Color)
  {
    self.font = typography.font
    self.textColor = textColor.color
    
    self.translatesAutoresizingMaskIntoConstraints = false
    self.heightAnchor.constraint(equalToConstant: typography.size.lineHeight).isActive = true
  }
}
