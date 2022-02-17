//
//  RoundColorButton.swift
//  Right on target
//
//  Created by justSmK on 16.02.2022.
//

import UIKit

class RoundColorButton: UIButton {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = layer.frame.height
    }
}
