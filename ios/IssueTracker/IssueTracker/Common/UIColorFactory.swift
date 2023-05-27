//
//  UIhexColorFactory.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/27.
//

import UIKit

struct UIColorFactory {
   func make(hexColor: String) -> UIColor {
      var rgbList = Array(repeating: CGFloat(0), count: 3)
      for index in 0..<3 {
         let startIndex = hexColor.index(hexColor.startIndex, offsetBy: (2 * index) + 1)
         let endIndex = hexColor.index(hexColor.startIndex, offsetBy: 2 * (index + 1))
         let maxhexColorValue: CGFloat = 255
         guard let hexColorValue = Int(hexColor[startIndex...endIndex], radix: 16) else {
            rgbList.append(CGFloat(0.5))
            continue
         }
         let floatValue = CGFloat(hexColorValue) / maxhexColorValue
         rgbList[index] = floatValue
      }
      return UIColor(red: rgbList[0], green: rgbList[1], blue: rgbList[2], alpha: 1)
   }
}
