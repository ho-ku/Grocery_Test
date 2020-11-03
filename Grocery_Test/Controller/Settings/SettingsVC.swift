//
//  SettingsVC.swift
//  Grocery_Test
//
//  Created by Денис Андриевский on 03.11.2020.
//

import UIKit

final class SettingsVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var mainView: SettingsView!
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainView.updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.delegate = self
    }

}

extension SettingsVC: SettingsViewDelegate {
    
    func didPressSignUpBtn() {
        if User.shared.token == nil {
            Router.navigateToSignUpVC(from: self)
        } else {
            User.shared.token = nil
            mainView.updateUI()
        }
    }
    
}
