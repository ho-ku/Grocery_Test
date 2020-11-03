//
//  ProductListView.swift
//  Grocery_Test
//
//  Created by Денис Андриевский on 03.11.2020.
//

import UIKit

protocol ProductListViewDelegate: class {
    func didPressRowWithNumber(_ number: Int)
}

final class ProductListView: UIView {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    var dataSource: [Product] = [] {
        didSet {
            updateUI()
        }
    }
    weak var delegate: ProductListViewDelegate?
    
    private func updateUI() {
        tableView.reloadData()
    }
    
}
// MARK: - UITableViewDelegate
extension ProductListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didPressRowWithNumber(indexPath.row)
    }
}
// MARK: - UITableViewDataSource
extension ProductListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: C.productCellIdentifier, for: indexPath) as? ProductCell else { return UITableViewCell() }
        let product = dataSource[indexPath.row]
        cell.productTitleLabel.text = product.title
        if let imgData = product.img, let image = UIImage(data: imgData) {
            cell.productImageView.image = image
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
}
