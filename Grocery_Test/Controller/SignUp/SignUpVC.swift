//
//  SignUpVC.swift
//  Grocery_Test
//
//  Created by Денис Андриевский on 03.11.2020.
//

import UIKit

final class SignUpVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var mainView: SignUpView!
    // MARK: - Properties
    private let requestService = RequestService()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.delegate = self
    }

}
// MARK: - SignUpViewDelegate
extension SignUpVC: SignUpViewDelegate {
    
    func didPressSignUpBtn(for state: SignUpState, username: String?, password: String?) {
        guard let username = username, username != "", let password = password, password != "" else {
            AlertService.presentSimpleOkAlert(self, title: C.oops, message: C.blankFielsWarning)
            return
        }
        requestService.proceedUser(state, username: username, password: password) { [unowned self] result in
            switch result {
            case .failure(let error):
                AlertService.presentSimpleOkAlert(self, title: C.oops, message: error.localizedDescription)
            case .success(let data):
                guard let parsedUser = try? JSONDecoder().decode(RequestUserModel.self, from: data) else { return }
                DispatchQueue.main.async { [unowned self] in
                    if !parsedUser.success, let message = parsedUser.message {
                        AlertService.presentSimpleOkAlert(self, title: C.oops, message: message)
                        return
                    }
                    guard let token = parsedUser.token else { return }
                    User.shared.token = token
                    Router.navigateToListVC(from: self)
                }
            }
        }
    }

}
