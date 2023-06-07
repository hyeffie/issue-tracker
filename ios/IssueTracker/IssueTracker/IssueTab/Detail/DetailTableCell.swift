//
//  DetailTableCell.swift
//  IssueTracker
//
//  Created by Wood on 2023/06/01.
//

import UIKit

class DetailTableCell: UITableViewCell {
   let writerBadge = IssueLabel(name: "작성자", color: "#FFFFFF")
   
   @IBOutlet weak var profileImage: UIImageView!
   @IBOutlet weak var commenterNameLabel: UILabel!
   @IBOutlet weak var timeLabel: UILabel!
   @IBOutlet weak var actionButton: UIButton!
   @IBOutlet weak var commentBodyLabel: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      configureViews()
   }
   
   override func prepareForReuse() {
      super.prepareForReuse()
      writerBadge.isHidden = false
   }
   
   private func addWriteBadge() {
      self.contentView.addSubview(writerBadge)
      writerBadge.translatesAutoresizingMaskIntoConstraints = false
      writerBadge.centerYAnchor.constraint(equalTo: actionButton.centerYAnchor).isActive = true
      writerBadge.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -28).isActive = true
   }
   
   private func configureFont() {
      self.commenterNameLabel.apply(typography: .init(weight: .bold, size: .large), textColor: .gray900)
      self.timeLabel.apply(typography: .init(weight: .regular, size: .small), textColor: .gray700)
      self.commentBodyLabel.apply(typography: .init(weight: .regular, size: .large), textColor: .gray900)
   }
   
   private func configureViews() {
      profileImage.applyRadius(style: .pill)
      addWriteBadge()
      configureFont()
   }
   
   func configure(writerName: String, comment: IssueDetailDTO.Comment) {
      commenterNameLabel.text = comment.userName
      timeLabel.text = LastTimeGenerator.calculateLastTime(past: comment.updateAt ?? "")
      commentBodyLabel.text = comment.content
      writerBadge.isHidden = writerName == comment.userName ? false : true
   }
   
   func configureImage(image: Data?) {
      guard let image = image,
            let profile = UIImage(data: image) else {
         return
      }
      
      self.profileImage.image = profile
   }
}
