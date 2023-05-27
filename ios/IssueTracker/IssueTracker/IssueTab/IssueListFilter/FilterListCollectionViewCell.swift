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
   
   func configureFont() {
      filterName.apply(typography: Typography(weight: .regular, size: .large),
                       textColor: .gray900)
   }
   
   func configureImage() {
      guard let checkmark = UIImage(systemName: "checkmark") else { return }
      let imageInset = UIEdgeInsets(top: -7, left: -7, bottom: -7, right: -7)
      self.selectionImageView.image = checkmark.withAlignmentRectInsets(imageInset)
      self.selectionImageView.tintColor = .systemBlue
   }
   
   func setSelected() {
      selectionImageView.tintColor = .systemGray
   }
   
   func setDeselected() {
      self.selectionImageView.tintColor = .systemBlue
   }
}
