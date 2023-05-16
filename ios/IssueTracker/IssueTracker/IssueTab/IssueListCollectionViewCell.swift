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
  
  override func awakeFromNib() {
      super.awakeFromNib()
      configureFont()
    }
    
    override func prepareForReuse() {
      super.prepareForReuse()
      emptyLabelStack()
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
    
    func addLabel(name: String, color: String) {
        self.labelStackView.addArrangedSubview(IssueLabel(name: name, color: color))
    }
  
  func configure(issue: IssueListDTO.Issue) {
      titleLabel.text = issue.title
      descriptionLabel.text = issue.description
      milestoneLabel.text = issue.milestone
      
      for label in issue.labels {
        let labelView = IssueLabel(name: label.title, color: label.color)
        self.labelStackView.addArrangedSubview(labelView)
      }
    }
  
  func emptyLabelStack() {
      labelStackView.arrangedSubviews.forEach { view in labelStackView.removeArrangedSubview(view) }
    }
}
