//
//  ProductDetailVC.swift
//  Grocery_Test
//
//  Created by Денис Андриевский on 03.11.2020.
//

import UIKit

final class ProductDetailVC: UITableViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var mainView: ProductDetailView!
    
    // MARK: - Properties
    var product: Product!
    private let requestService = RequestService()
    
    // MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        mainView.del = self
        mainView.update(with: product)
        performRequest()
    }
    
    private func performRequest() {
        requestService.fetchReviews(for: product.id) { [unowned self] result in
            switch result {
            case .failure(_):
                print("Error")
            case .success(let data):
                guard let parsedReviews = try? JSONDecoder().decode([ReviewModel].self, from: data) else { return }
                self.product.reviews = parsedReviews.map { Review(from: $0) }
                DispatchQueue.main.async { [unowned self] in
                    self.mainView.update(with: self.product)
                }
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == C.reviewSegueIdentifier {
            guard let dest = segue.destination as? ReviewVC else { return }
            dest.productID = product.id
        }
    }

}
// MARK: - ProductDetailViewDelegate
extension ProductDetailVC: ProductDetailViewDelegate {
    
    func didPressWriteReview() {
        if User.shared.token != nil {
            performSegue(withIdentifier: C.reviewSegueIdentifier, sender: self)
        } else {
            AlertService.presentYouMustSignUpAlert(self, cancelBlock: {})
        }
    }
    
}
