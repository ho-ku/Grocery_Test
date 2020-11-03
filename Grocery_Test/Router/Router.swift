//
//  Router.swift
//  Grocery_Test
//
//  Created by Денис Андриевский on 03.11.2020.
//

import UIKit

final class Router {
    
    static func navigateToSignUpVC(from vc: UIViewController) {
        guard let signUpVC = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: C.mainSignUpVCIdentifier) as? SignUpVC else { return }
        vc.present(signUpVC, animated: true)
    }
    
    static func navigateToListVC(from vc: UIViewController) {
        guard let mainListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: C.mainListVCIdentifier) as? UITabBarController else { return }
        vc.present(mainListVC, animated: true)
    }
    
}
