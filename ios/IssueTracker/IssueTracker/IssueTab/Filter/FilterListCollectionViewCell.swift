//
//  FilterListCollectionViewCell.swift
//  IssueTracker
//
//  Created by 1 on 2023/05/19.
//

import UIKit

class FilterListCollectionViewCell: UICollectionViewCell {
   @IBOutlet weak var filterName: UILabel!
   @IBOutlet weak var selectionImageView: UIImageView!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      configureImage()
   }
   
   override func prepareForReuse() {
      super.prepareForReuse()
      self.setDeselected()
   }
   
   func configure(name: String, isSelected: Bool = false) {
      self.filterName.text = name
      guard isSelected else {
         return
      }
      self.setSelected()
   }
   
   func configureFont() {
      filterName.apply(typography: Typography(weight: .regular, size: .large),
                       textColor: .gray900)
   }
   
   func configureImage() {
      guard let checkmark = UIImage(systemName: "checkmark") else { return }
      let imageInset = UIEdgeInsets(top: -7, left: -7, bottom: -7, right: -7)
      self.selectionImageView.image = checkmark.withAlignmentRectInsets(imageInset)
      self.selectionImageView.tintColor = .systemGray
   }
   
   func setSelected() {
      selectionImageView.tintColor = .systemBlue
   }
   
   func setDeselected() {
      self.selectionImageView.tintColor = .systemGray
   }
}
