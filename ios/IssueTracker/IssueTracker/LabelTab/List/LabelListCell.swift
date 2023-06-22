//
//  LabelListCell.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/24.
//

import UIKit

class LabelListCell: UICollectionViewCell {
   static var cellId: String = "LabelListCell"
   
   var nameLabel: IssueLabel!
   @IBOutlet weak var container: UIStackView!
   @IBOutlet weak var descriptionLabel: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      setDescriptionFont()
   }
   
   func setDescriptionFont() {
      descriptionLabel.apply(typography: .init(weight: .regular, size: .medium), textColor: .gray800)
   }
   
   func configure(with label: LabelDetail) {
      nameLabel = IssueLabel(name: label.labelName, color: label.backgroundColor ?? "#FFFFFF")
      container.insertArrangedSubview(nameLabel, at: 0)
      if let description = label.description,
         description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
         descriptionLabel.text = label.description
      } else {
         descriptionLabel.isHidden = true
      }
      descriptionLabel.text = label.description
      setNeedsUpdateConstraints()
   }
   
   override func prepareForReuse() {
      super.prepareForReuse()
      descriptionLabel.isHidden = false
      emptyLabelStack()
   }
   
   override func preferredLayoutAttributesFitting(
      _ layoutAttributes: UICollectionViewLayoutAttributes
   ) -> UICollectionViewLayoutAttributes {
      let atts = super.preferredLayoutAttributesFitting(layoutAttributes)
      atts.size = .init(width: atts.size.width, height: 84)
      return atts
   }
   
   func emptyLabelStack() {
      container.arrangedSubviews.forEach { view in
         guard let label = view as? IssueLabel else { return }
         label.removeFromSuperview()
      }
   }
}
