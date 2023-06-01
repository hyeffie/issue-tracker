//
//  DetailTableHeader.swift
//  IssueTracker
//
//  Created by Wood on 2023/06/01.
//

import UIKit

class DetailTableHeader: UITableViewCell {
   @IBOutlet weak var title: UILabel!
   @IBOutlet weak var number: UILabel!
   @IBOutlet weak var status: IssueLabel!
   @IBOutlet weak var editTime: UILabel!

   private let openColor  = "#007AFF"
   private let closeColor = "#543ABE"
   
   override func awakeFromNib() {
      super.awakeFromNib()
      configureFont()
   }
   
   func configureFont() {
      title.apply(typography: Typography(weight: .bold, size: .xlarge),
                  textColor: .gray900)
      number.apply(typography: Typography(weight: .regular, size: .xlarge),
                   textColor: .gray600)
      status.apply(typography: Typography(weight: .regular, size: .medium),
                   textColor: .gray50)
   }
   
   func configure(headerData: IssueDetailHeaderData) {
      self.title.text = headerData.title
      self.number.text = "#\(headerData.number)"
      
      switch headerData.status {
      case true:
         self.status.text = "열린 이슈"
         self.status.backgroundColor = UIColorFactory.make(hexColor: openColor)
      case false:
         self.status.text = "닫힌 이슈"
         self.status.backgroundColor = UIColorFactory.make(hexColor: closeColor)
      }
      
      let time = LastTimeGenerator.calculateLastTime(past: headerData.editTime)
      self.editTime.text = "\(time) 전, \(headerData.userName)님이 작성했습니다."
   }
}
