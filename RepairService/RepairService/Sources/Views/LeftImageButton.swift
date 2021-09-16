//
//  LeftImageButton.swift
//  RepairService
//
//  Created by  Buxlan on 9/16/21.
//

import UIKit

class LeftImageButton: UIButton {
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleRect = super.titleRect(forContentRect: contentRect)
        let imageSize = currentImage?.size ?? .zero
        let availableWidth = contentRect.width - imageEdgeInsets.right - imageSize.width - titleRect.width
        return titleRect.offsetBy(dx: -round(availableWidth / 2)+8, dy: 0)
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageSize = currentImage?.size ?? .zero
        return CGRect(x: 8, y: 8, width: imageSize.width, height: imageSize.width)
    }
}
