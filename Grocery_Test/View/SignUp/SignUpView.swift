//
//  SignUpView.swift
//  Grocery_Test
//
//  Created by Денис Андриевский on 03.11.2020.
//

import UIKit

enum SignUpState {
    case signUp
    case logIn
}

protocol SignUpViewDelegate: class {
    func didPressSignUpBtn(for state: SignUpState, username: String?, password: String?)
}

final class SignUpView: UIView {

    // MARK: - IBOutlets
    @IBOutlet private weak var usernameField: UITextField! {
        didSet {
            usernameField.delegate = self
            usernameField.tag = 1
        }
    }
    @IBOutlet private weak var passwordField: UITextField! {
        didSet {
            passwordField.autocorrectionType = .no
            passwordField.delegate = self
            passwordField.tag = 2
        }
    }
    @IBOutlet private weak var signUpBtn: UIButton!
    @IBOutlet private weak var bottomLabel: UILabel!
    @IBOutlet private weak var bottomBtn: UIButton!
    
    // MARK: - Properties
    private var state: SignUpState = .signUp {
        didSet {
            updateUI()
        }
    }
    weak var delegate: SignUpViewDelegate?
    
    private func updateUI() {
        switch state {
        case .signUp:
            signUpBtn.setTitle(C.signUpTitle, for: .normal)
            bottomBtn.setTitle(C.logInTitle, for: .normal)
            bottomLabel.text = C.alreadyHaveAccount
        case .logIn:
            signUpBtn.setTitle(C.logInTitle, for: .normal)
            bottomBtn.setTitle(C.signUpTitle, for: .normal)
            bottomLabel.text = C.dontHaveAccount
        }
    }
    
    // MARK: - IBActions
    @IBAction func bottomBtnPressed(_ sender: UIButton) {
        state = state == .signUp ? .logIn : .signUp
    }
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        delegate?.didPressSignUpBtn(for: state, username: usernameField.text, password: passwordField.text)
    }
    
}

extension SignUpView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let nextField = viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        }
        return true
    }
    
}
