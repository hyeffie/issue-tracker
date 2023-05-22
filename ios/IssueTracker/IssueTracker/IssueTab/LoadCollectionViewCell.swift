//
//  LoadCollectionViewCell.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/18.
//

import UIKit

final class LoadCollectionViewCell: UICollectionViewCell {
   @IBOutlet weak var indicator: UIActivityIndicatorView!
   
   func start() {
      indicator.startAnimating()
   }
   
   func stop() {
      indicator.stopAnimating()
   }
}
