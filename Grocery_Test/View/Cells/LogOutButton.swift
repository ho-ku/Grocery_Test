//
//  LogOutButton.swift
//  Grocery_Test
//
//  Created by Денис Андриевский on 03.11.2020.
//

import UIKit

final class LogOutButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        customizeView()
    }
    
    func update() {
        customizeView()
    }

    private func customizeView() {
        self.layer.borderColor = UIColor.systemGreen.cgColor
        if User.shared.token != nil {
            self.backgroundColor = .white
            self.setTitle(C.logOutTitle, for: .normal)
            self.setTitleColor(.systemGreen, for: .normal)
            self.layer.borderWidth = 2
        } else {
            self.backgroundColor = .systemGreen
            self.setTitleColor(.white, for: .normal)
            self.setTitle(C.signUpTitle, for: .normal)
            self.layer.borderWidth = 0
        }
    }

}
