//
//  SettingsView.swift
//  Grocery_Test
//
//  Created by Денис Андриевский on 03.11.2020.
//

import UIKit

protocol SettingsViewDelegate: class {
    func didPressSignUpBtn()
}

final class SettingsView: UIView {

    // MARK: - IBOutlets
    @IBOutlet private weak var userImageView: UIImageView! {
        didSet {
            userImageView.layer.cornerRadius = userImageView.layer.frame.height/2 - 4
            userImageView.clipsToBounds = true
        }
    }
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var settingsTableView: UITableView!
    @IBOutlet private weak var signUpBtn: LogOutButton!
    
    // MARK: - Properties
    weak var delegate: SettingsViewDelegate?

    func updateUI() {
        if let imgData = User.shared.imageData, let image = UIImage(data: imgData) {
            userImageView.image = image
        } else {
            userImageView.image = nil
        }
        var nameTitle = ""
        if let name = User.shared.name {
            nameTitle += name
            nameTitle += " "
        }
        if let surname = User.shared.surname {
            nameTitle += surname
        }
        if nameTitle.isEmpty {
            nameTitle = C.anonymTitle
        }
        nameLabel.text = nameTitle
        signUpBtn.update()
    }
    
    // MARK: - IBActions
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        delegate?.didPressSignUpBtn()
    }
    
}
