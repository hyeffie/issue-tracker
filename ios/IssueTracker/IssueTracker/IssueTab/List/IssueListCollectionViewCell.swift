//
//  IssueCell.swift
//  IssueTracker
//
//  Created by 1 on 2023/05/11.
//

import UIKit

class IssueListCollectionViewCell: UICollectionViewCell {
   static var cellId: String = "IssueListCollectionViewCell"
   let imageInset = UIEdgeInsets(top: -7, left: -7, bottom: -7, right: -7)
   
   @IBOutlet var titleLabel: UILabel!
   @IBOutlet var checkBoxImageView: UIImageView!
   @IBOutlet var descriptionLabel: UILabel!
   @IBOutlet var milestoneLabel: UILabel!
   @IBOutlet var labelStackView: UIStackView!
   @IBOutlet weak var emptyView: UIView!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      configureFont()
      configureImage()
   }
   
   override func prepareForReuse() {
      super.prepareForReuse()
      labelStackView.isHidden = false
      emptyLabelStack()
      didDeSelect()
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
      self.checkBoxImageView.image = chevron.withAlignmentRectInsets(imageInset)
   }
   
   func addLabel(name: String, color: String) {
      let label = IssueLabel(name: name, color: color)
      self.labelStackView.insertArrangedSubview(label, at: 0)
   }
   
   func emptyLabelStack() {
      labelStackView.arrangedSubviews.forEach { view in
         guard let label = view as? IssueLabel else { return }
         view.removeFromSuperview()
      }
   }
   
   func configure(issue: IssueSummary, isSelected: Bool) {
      titleLabel.text = "#\(issue.issueId) \(issue.title)"
      descriptionLabel.text = issue.content
      milestoneLabel.text = issue.milestoneName
      
      if issue.labelList.isEmpty {
         labelStackView.isHidden = true
         return
      }
      
      for label in issue.labelList.reversed() {
         addLabel(name: label.labelName, color: label.backgroundColor)
      }
      
      labelStackView.sizeToFit()
      guard isSelected else { return }
      didSelect()
   }
   
   func didSelect() {
      let filledCheckmark = UIImage(systemName: "checkmark.circle.fill")
      self.checkBoxImageView.image = filledCheckmark?.withAlignmentRectInsets(imageInset)
      self.checkBoxImageView.tintColor = .systemBlue
      self.backgroundColor = Color.gray100.color
      self.emptyView.backgroundColor = Color.gray100.color
   }
   
   func didDeSelect() {
      configureImage()
      self.backgroundColor = .systemBackground
      self.emptyView.backgroundColor = .systemBackground
   }
}
