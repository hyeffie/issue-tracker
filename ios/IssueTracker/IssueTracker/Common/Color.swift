//
//  Color.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/11.
//

import UIKit

enum Color: String {
   case gray50
   case gray100
   case gray200
   case gray300
   case gray400
   case gray500
   case gray600
   case gray700
   case gray800
   case gray900
   case blue
   case red
   case purple
   
   var color: UIColor {
      UIColor(named: self.rawValue) ?? .white
   }
}

extension Color {
   static func randomizeColorHex() -> String {
      func randomValue() -> Int { Int.random(in: 0...255) }
      func convertToHex(from value: Int) -> String { String(format: "%02X", value) }
      let hexString = "RGB".map { _ in convertToHex(from: randomValue()) }.reduce("", +)
      return hexString
   }
}

extension Color {
   static func makeString(from uiColor: UIColor) -> String {
      let defaultColor = "FFFFFF"
      guard let components = uiColor.cgColor.components else { return defaultColor }
      // TODO: components index out of range
      let red = components[0]
      let green = components[1]
      let blue = components[2]
      let resultHex = [red, green, blue].reduce("#") { resultString, value in
         let partialHex = String(format: "%02X", value)
         return resultString + partialHex
      }
      return resultHex.count == 6 ? resultHex : defaultColor
   }
}
