//
//  PaddingLabel.swift
//  WatchTime
//
//  Created by Buse Sahinbas on 27.03.2023.
//

import Foundation
import UIKit

class UILabelPadding: UILabel {
    let padding = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
        
    }
    
}
