//
//  TypoGraphy.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/11.
//

import UIKit

struct TypoGraphy {
   enum Weight {
      case bold
      case regular
      
      var value: UIFont.Weight {
         switch self {
         case .bold: return .bold
         case .regular: return .regular
         }
      }
   }
   
   enum Size {
      case xxlarge
      case xlarge
      case large
      case medium
      case small
      
      var fontSize: CGFloat {
         switch self {
         case .xxlarge: return 32
         case .xlarge: return 24
         case .large: return 18
         case .medium: return 15
         case .small: return 12
         }
      }
      
      var lineHeight: CGFloat {
         switch self {
         case .xxlarge: return 48
         case .xlarge: return 40
         case .large: return 32
         case .medium: return 28
         case .small: return 20
         }
      }
   }
   
   let weight: Weight
   let size: Size
   
   var font: UIFont {
      UIFont.systemFont(ofSize: size.fontSize, weight: weight.value, width: .standard)
   }
}
