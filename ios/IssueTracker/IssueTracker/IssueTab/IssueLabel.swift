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
    
    convenience init(name: String, color: String) {
        self.init()
        self.text = name
        self.font = TypoGraphy(weight: .regular, size: .small).font
        self.backgroundColor = convertToUIColor(color: color)
        self.textColor = isBright(self.backgroundColor) ? .white : .black
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: Self.padding))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // TODO: - cornerRadius 값 임의 선택
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    func convertToUIColor(color: String) -> UIColor {
        var rgbList: [CGFloat] = []
        for index in 0..<3 {
            let startIndex = color.index(color.startIndex, offsetBy: (2*index) + 1)
            let endIndex = color.index(color.startIndex, offsetBy: 2 * (index+1))
            let maxColorValue: CGFloat = 255
            guard let colorValue = Int32(color[startIndex...endIndex], radix: 16) else {
                break
            }
            
            rgbList.append(CGFloat(colorValue) / maxColorValue )
        }
        
        return UIColor(red: rgbList[0], green: rgbList[1], blue: rgbList[2], alpha: 1)
    }
    
    func isBright(_ backgroundColor: UIColor?) -> Bool {
        // TODO: - Optional Binding 예외 처리
        guard let colorValueList = backgroundColor?.cgColor.components else {
            return false
        }
        
        let averageOfColorValues = colorValueList.reduce(0, +) / 3
        let standarOfBrightness: CGFloat = 0.5
        guard averageOfColorValues >= standarOfBrightness else {
            return false
        }
        return true
    }
}
