//
//  UIView+Rounding.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/31.
//

import UIKit

extension UIView {
   enum RoundingStyle {
      case regular
      case large
      case pill
   }
   
   func applyRadius(style: RoundingStyle) {
      var radius: CGFloat
      switch style {
      case .regular: radius = 10
      case .large: radius = 20
      case .pill: radius = frame.size.height / 2
      }
      layer.cornerRadius = radius
   }
}
