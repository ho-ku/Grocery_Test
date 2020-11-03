//
//  ProductListVC.swift
//  Grocery_Test
//
//  Created by Денис Андриевский on 03.11.2020.
//

import UIKit

// MARK: - Test Account (username: "test123", password: "123456")

final class ProductListVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var mainView: ProductListView!
    // MARK: - Properties
    private let requestService = RequestService()
    private var dataSource: [Product] = []
    private var selectedProduct: Product?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if dataSource.isEmpty {
            performRequest()
        }
    }
    
    private func performRequest() {
        requestService.fetchGrocery { [unowned self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async { [unowned self] in
                    AlertService.presentSimpleOkAlert(self, title: C.oops, message: error.localizedDescription)
                }
            case .success(let data):
                guard let parsedModel = try? JSONDecoder().decode([ProductModel].self, from: data) else { return }
                self.dataSource = parsedModel.map { Product(from: $0) }
                self.performImageRequestForDataSource(with: parsedModel)
                
                DispatchQueue.main.async { [unowned self] in
                    self.mainView.dataSource = self.dataSource
                }
            }
        }
    }
    
    private func performImageRequestForDataSource(with parsedModel: [ProductModel]) {
        for (index, _) in dataSource.enumerated() {
            let modelObj = parsedModel[index]
            requestService.fetchImage(image: modelObj.img) { [unowned self] result in
                switch result {
                case .failure(_):
                    print("Error fetching image")
                case .success(let data):
                    dataSource[index].img = data
                    DispatchQueue.main.async { [unowned self] in
                        self.mainView.dataSource = self.dataSource
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == C.detailProductSegueIdentifier {
            guard let dest = segue.destination as? ProductDetailVC, let selectedProduct = selectedProduct else { return }
            dest.product = selectedProduct
        }
    }

}
// MARK: - ProductListViewDelegate
extension ProductListVC: ProductListViewDelegate {
    
    func didPressRowWithNumber(_ number: Int) {
        let product = self.dataSource[number]
        selectedProduct = product
        performSegue(withIdentifier: C.detailProductSegueIdentifier, sender: self)
    }
    
}
