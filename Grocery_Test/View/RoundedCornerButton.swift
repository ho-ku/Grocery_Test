//
//  RoundedCornerButton.swift
//  Grocery_Test
//
//  Created by Денис Андриевский on 03.11.2020.
//

import UIKit
@IBDesignable
final class RoundedCornerButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 10
    
    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }
    
    private func customizeView() {
        self.layer.cornerRadius = cornerRadius
    }
    
}
