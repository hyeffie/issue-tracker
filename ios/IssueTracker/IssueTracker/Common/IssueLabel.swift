//
//  IssueLabel.swift
//  IssueTracker
//
//  Created by 1 on 2023/05/13.
//

import UIKit

class IssueLabel: UILabel {
   private static let padding = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
   
   override var intrinsicContentSize: CGSize {
      var contentSize = super.intrinsicContentSize
      contentSize.width += Self.padding.left + Self.padding.right
      contentSize.height += Self.padding.top + Self.padding.bottom
      return contentSize
   }
   
   convenience init(name: String, color: String, forWriterBadge: Bool = false) {
      self.init()
      self.text = forWriterBadge ? "작성자" : name
      self.font = Typography(weight: .regular, size: .small).font
      if forWriterBadge {
         self.backgroundColor = .white
         self.textColor = Color.gray700.color
      } else {
         self.backgroundColor = convertToUIColor(color: color)
         self.textColor = isBright(self.backgroundColor) ? .black : .white
      }
   }
   
   override func drawText(in rect: CGRect) {
      super.drawText(in: rect.inset(by: Self.padding))
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      layer.cornerRadius = self.frame.size.height / 2
      layer.masksToBounds = true
   }
   
   func convertToUIColor(color: String) -> UIColor {
      var rgbList = Array(repeating: CGFloat(0), count: 3)
      for index in 0..<3 {
         let startIndex = color.index(color.startIndex, offsetBy: (2*index) + 1)
         let endIndex = color.index(color.startIndex, offsetBy: 2 * (index+1))
         let maxColorValue: CGFloat = 255
         guard let colorValue = Int(color[startIndex...endIndex], radix: 16) else {
            rgbList.append(CGFloat(0.5))
            continue
         }
         let floatValue = CGFloat(colorValue) / maxColorValue
         rgbList[index] = floatValue
      }
      return UIColor(red: rgbList[0], green: rgbList[1], blue: rgbList[2], alpha: 1)
   }
   
   func isBright(_ backgroundColor: UIColor?) -> Bool {
      guard var colorValueList = backgroundColor?.cgColor.components else {
         self.layer.borderWidth = 0.5
         return false
      }
      
      colorValueList.removeLast()
      let averageOfColorValues = colorValueList.reduce(0, +) / 3
      let standarOfBrightness: CGFloat = 0.5
      guard averageOfColorValues >= standarOfBrightness else {
         return false
      }
      
      self.layer.borderWidth = 0.5
      return true
   }
   
   func changeColor(to colorHex: String) {
      self.backgroundColor = convertToUIColor(color: colorHex)
      self.textColor = isBright(self.backgroundColor) ? .black : .white
   }
   
   func changeName(to newName: String) {
      self.text = newName
   }
}
