//
//  PaddingLabel.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 13/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import Foundation
import UIKit

class PaddingLabel : UILabel {
    
    let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSizeThatFits = super.sizeThatFits(size)
        let width = superSizeThatFits.width + padding.left + padding.right
        
        let height = superSizeThatFits.height + padding.top + padding.bottom
        return CGSize(width: width, height: height)
    }
}
