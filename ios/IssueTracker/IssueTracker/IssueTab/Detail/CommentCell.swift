//
//  CommentCell0.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/24.
//

import UIKit

class CommentCell: UICollectionViewCell {
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
      writerBadge.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: 28).isActive = true
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
   
   func configure(comment: IssueDetailDTO.Comment) {
      commenterNameLabel.text = comment.userName
      timeLabel.text = "5분전" // TODO: 댓글 시간 로직
      timeLabel.text = comment.content
      writerBadge.isHidden = true // TODO: 댓글 작성자가 본문 작성자인지 > bool > badge 추가
   }
}
