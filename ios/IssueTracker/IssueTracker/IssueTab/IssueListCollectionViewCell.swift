//
//  IssueCell.swift
//  IssueTracker
//
//  Created by 1 on 2023/05/11.
//

import UIKit

class IssueListCollectionViewCell: UICollectionViewCell {
   @IBOutlet var titleLabel: UILabel!
   @IBOutlet var checkBoxImageView: UIImageView!
   @IBOutlet var descriptionLabel: UILabel!
   @IBOutlet var milestoneLabel: UILabel!
   @IBOutlet var labelStackView: UIStackView!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      configureFont()
      configureImage()
      labelStackView.sizeToFit()
   }
   
   override func prepareForReuse() {
      super.prepareForReuse()
      emptyLabelStack()
   }
   
   func configureFont() {
      self.titleLabel.apply(typography: TypoGraphy(weight: .bold, size: .large),
                            textColor: .gray900)
      self.descriptionLabel.apply(typography: TypoGraphy(weight: .regular, size: .medium),
                                  textColor: .gray800,
                                  willApplyHeight: false)
      self.milestoneLabel.apply(typography: TypoGraphy(weight: .regular, size: .medium),
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
      labelStackView.arrangedSubviews.forEach { view in view.removeFromSuperview()
      }
   }
}
