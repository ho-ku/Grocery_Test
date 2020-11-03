//
//  EditSettingsView.swift
//  Grocery_Test
//
//  Created by Денис Андриевский on 03.11.2020.
//

import UIKit

protocol EditSettingsViewDelegate: class {
    func didPressChangeImageBtn()
    func didCancel()
    func didPressDone(name: String?, surname: String?)
}

final class EditSettingsView: UIView {

    // MARK: - IBOutltes
    @IBOutlet weak var userImageView: UIImageView! {
        didSet {
            userImageView.layer.cornerRadius = userImageView.layer.frame.height/2 - 4
            userImageView.clipsToBounds = true
        }
    }
    @IBOutlet private weak var nameField: UITextField! {
        didSet {
            nameField.delegate = self
            nameField.tag = 1
        }
    }
    @IBOutlet private weak var surnameField: UITextField! {
        didSet {
            surnameField.delegate = self
            surnameField.tag = 2
        }
    }
    
    // MARK: - Properties
    weak var delegate: EditSettingsViewDelegate?
    func updateUI() {
        if let imgData = User.shared.imageData, let image = UIImage(data: imgData) {
            userImageView.image = image
        }
        if let name = User.shared.name {
            nameField.placeholder = name
        }
        if let surname = User.shared.surname {
            surnameField.placeholder = surname
        }
    }
    
    @IBAction func changeBtnPressed(_ sender: UIButton) {
        delegate?.didPressChangeImageBtn()
    }
    
    @IBAction func doneBtnPressed(_ sender: UIButton) {
        delegate?.didPressDone(name: nameField.text, surname: surnameField.text)
    }
    
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        delegate?.didCancel()
    }
    
}
// MARK: - UITextFieldDelegate
extension EditSettingsView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let nextField = self.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        }
        return true
    }
    
}
