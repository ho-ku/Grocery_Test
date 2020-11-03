//
//  AlertService.swift
//  Grocery_Test
//
//  Created by Денис Андриевский on 03.11.2020.
//

import UIKit

final class AlertService {
    
    static func presentSimpleOkAlert(_ vc: UIViewController, title: String?, message: String?, block: @escaping () -> Void = { }) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            block()
        }))
        vc.present(alertController, animated: true)
    }
    
    static func presentYouMustSignUpAlert(_ vc: UIViewController, cancelBlock: @escaping () -> Void) {
        let alertController = UIAlertController(title: C.oops, message: C.youMustSignUpMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: C.signUpTitle, style: .default, handler: { [unowned vc] action in
            Router.navigateToSignUpVC(from: vc)
        }))
        alertController.addAction(UIAlertAction(title: C.cancelTitle, style: .cancel, handler: { action in
            cancelBlock()
        }))
        vc.present(alertController, animated: true)
    }
    
}
