//
//  SwipeAction.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/24.
//

import UIKit

enum SwipeAction {
   case close
   case open
   case delete
   case edit
   
   var title: String {
      switch self {
      case .close: return "닫기"
      case .open: return "다시 열기"
      case .delete: return "삭제"
      case .edit: return "편집"
      }
   }
   
   var color: UIColor {
      switch self {
      case .close: return Color.purple.color
      case .open: return UIColor.systemGreen
      case .delete: return Color.red.color
      case .edit: return Color.blue.color
      }
   }
   
   var icon: UIImage? {
      switch self {
      case .close: return UIImage(systemName: "archivebox.fill")
      case .open: return UIImage(systemName: "arrowshape.turn.up.left.fill")
      case .delete: return UIImage(systemName: "trash.fill")
      case .edit: return UIImage(systemName: "pencil.line")
      }
   }
   
   func makeAction(
      hasImage: Bool = true,
      withHandler handler: @escaping UIContextualAction.Handler
   ) -> UIContextualAction {
      let action = UIContextualAction(style: .normal, title: title, handler: handler)
      if hasImage { action.image = icon }
      action.backgroundColor = color
      return action
   }
}
