//
//  IssueLabel.swift
//  IssueTracker
//
//  Created by 1 on 2023/05/13.
//

import UIKit

class IssueLabel: UILabel {
    private static let padding = UIEdgeInsets(top: 4,
                                            left: 16,
                                            bottom: 4,
                                            right: 16)
  
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += Self.padding.left + Self.padding.right
        contentSize.height += Self.padding.top + Self.padding.bottom
        return contentSize
    }
}
