//
//  IssueCell.swift
//  IssueTracker
//
//  Created by 1 on 2023/05/11.
//

import UIKit

class IssueListCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var milestoneLabel: UILabel!
    @IBOutlet var labelStackView: UIStackView!
    
    func configureFont() {
        self.titleLabel.apply(typography: TypoGraphy(weight: .bold,
                                                     size: .large),
                              textColor: .gray900)
        self.descriptionLabel.apply(typography: TypoGraphy(weight: .regular,
                                                     size: .medium),
                              textColor: .gray800)
        self.milestoneLabel.apply(typography: TypoGraphy(weight: .regular,
                                                         size: .medium),
                                  textColor: .gray800)
    }
}
