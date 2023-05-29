//
//  MilestoneListCell.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/25.
//

import UIKit

class MilestoneListCell: UICollectionViewCell {
   static var cellId: String = "MilestoneListCell"
   
   @IBOutlet weak var nameLabel: UILabel!
   @IBOutlet weak var progressLabel: UILabel!
   @IBOutlet weak var descriptionLabel: UILabel!
   @IBOutlet weak var dueContainer: UIStackView!
   @IBOutlet weak var dueDateLabel: UILabel!
   @IBOutlet weak var completedAtLabel: UILabel!
   @IBOutlet weak var openedIssueLabel: UILabel!
   @IBOutlet weak var openedCountLabel: UILabel!
   @IBOutlet weak var closedIssueLabel: UILabel!
   @IBOutlet weak var closedCountLabel: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      setLabelFont()
   }
   
   override func prepareForReuse() {
      super.prepareForReuse()
      descriptionLabel.isHidden = false
      dueContainer.isHidden = false
   }
   
   func setLabelFont() {
      nameLabel.apply(typography: .init(weight: .bold, size: .large), textColor: .gray900)
      progressLabel.apply(typography: .init(weight: .bold, size: .large), textColor: .blue)
      descriptionLabel.apply(typography: .init(weight: .regular, size: .medium), textColor: .gray800)
      dueDateLabel.apply(typography: .init(weight: .regular, size: .medium), textColor: .gray800)
      completedAtLabel.apply(typography: .init(weight: .regular, size: .medium), textColor: .gray800)
      openedIssueLabel.apply(typography: .init(weight: .regular, size: .small), textColor: .gray700)
      openedCountLabel.apply(typography: .init(weight: .regular, size: .small), textColor: .gray700)
      closedIssueLabel.apply(typography: .init(weight: .regular, size: .small), textColor: .gray700)
      closedCountLabel.apply(typography: .init(weight: .regular, size: .small), textColor: .gray700)
   }
   
   func configure(with milestone: MilestoneDetail) {
      nameLabel.text = milestone.name
      progressLabel.text = "\(milestone.progress)%"
      
      if let desc = milestone.description, desc.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
         descriptionLabel.text = milestone.description
      } else {
         descriptionLabel.isHidden = true
      }
      
      if let completedAt = milestone.completedAt,
         completedAt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
         completedAtLabel.text = milestone.completedAt
      } else {
         dueContainer.isHidden = true
      }
      
      openedCountLabel.text = "\(milestone.countAllOpenedIssues)"
      closedCountLabel.text = "\(milestone.countAllClosedIssues)"
   }
}
