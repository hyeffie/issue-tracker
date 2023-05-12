//
//  IssueCell.swift
//  IssueTracker
//
//  Created by 1 on 2023/05/11.
//

import UIKit

class IssueCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var milestoneLabel: UILabel!
    @IBOutlet var labelStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
