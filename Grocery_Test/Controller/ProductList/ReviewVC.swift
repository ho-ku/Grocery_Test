//
//  ReviewVC.swift
//  Grocery_Test
//
//  Created by Денис Андриевский on 03.11.2020.
//

import UIKit

final class ReviewVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var mainView: ReviewView!

    // MARK: - Properties
    var productID: Int!
    private let requestService = RequestService()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.delegate = self
    }

}
// MARK: - ReviewViewDelegate
extension ReviewVC: ReviewViewDelegate {
    
    func doneBtnPressed(with rate: Int, text: String) {
        requestService.postReview(productId: productID, rate: rate, review: text) { [unowned self] result in
            DispatchQueue.main.async { [unowned self] in
                switch result {
                case .failure(let error):
                    AlertService.presentSimpleOkAlert(self, title: C.oops, message: "Error: \(error.localizedDescription)")
                case .success(_):
                    AlertService.presentSimpleOkAlert(self, title: C.successTitle, message: C.successMessage) { [unowned self] in
                        navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
}
