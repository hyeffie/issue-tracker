//
//  IssueCell.swift
//  IssueTracker
//
//  Created by 1 on 2023/05/11.
//

import UIKit

class IssueListCollectionViewCell: UICollectionViewCell {
   static var cellId: String = "IssueListCollectionViewCell"
   
   @IBOutlet var titleLabel: UILabel!
   @IBOutlet var checkBoxImageView: UIImageView!
   @IBOutlet var descriptionLabel: UILabel!
   @IBOutlet var milestoneLabel: UILabel!
   @IBOutlet var labelStackView: UIStackView!
   @IBOutlet weak var labelStackContainer: UIView!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      configureFont()
      configureImage()
   }
   
   override func prepareForReuse() {
      super.prepareForReuse()
      labelStackContainer.isHidden = false
      emptyLabelStack()
   }
   
   func configureFont() {
      self.titleLabel.apply(typography: Typography(weight: .bold, size: .large),
                            textColor: .gray900)
      self.descriptionLabel.apply(typography: Typography(weight: .regular, size: .medium),
                                  textColor: .gray800)
      self.milestoneLabel.apply(typography: Typography(weight: .regular, size: .medium),
                                textColor: .gray800)
   }
   
   func configureImage() {
      guard let chevron = UIImage(systemName: "chevron.right") else { return }
      let imageInset = UIEdgeInsets(top: -7, left: -7, bottom: -7, right: -7)
      self.checkBoxImageView.image = chevron.withAlignmentRectInsets(imageInset)
   }
   
   func addLabel(name: String, color: String) {
      let label = IssueLabel(name: name, color: color)
      self.labelStackView.addArrangedSubview(label)
   }
   
   func emptyLabelStack() {
      labelStackView.arrangedSubviews.forEach { view in view.removeFromSuperview() }
   }
   
   func configure(issue: IssueList.Issue) {
      titleLabel.text = issue.title
      descriptionLabel.text = issue.content
      milestoneLabel.text = issue.milestoneName
      
      if issue.labelList.isEmpty {
         labelStackContainer.isHidden = true
         return
      }
      
      for label in issue.labelList {
         addLabel(name: label.labelName, color: label.backgroundColor)
      }
      labelStackView.sizeToFit()
   }
}
