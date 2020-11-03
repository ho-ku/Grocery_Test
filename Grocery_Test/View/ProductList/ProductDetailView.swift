//
//  ProductDetailView.swift
//  Grocery_Test
//
//  Created by Денис Андриевский on 03.11.2020.
//

import UIKit

protocol ProductDetailViewDelegate: class {
    func didPressWriteReview()
}

final class ProductDetailView: UITableView {

    // MARK: - IBOutlets
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productTitleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var reviewsCollectionView: UICollectionView! {
        didSet {
            reviewsCollectionView.delegate = self
            reviewsCollectionView.dataSource = self
        }
    }
    weak var del: ProductDetailViewDelegate?
    private var reviews: [Review] = [] {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        reviewsCollectionView.reloadData()
    }
    
    func update(with product: Product) {
        if let imgData = product.img, let image = UIImage(data: imgData) {
            productImageView.image = image
        }
        productTitleLabel.text = product.title
        descriptionLabel.text = product.description
        reviews = product.reviews
    }
    
    // MARK: - IBActions
    @IBAction func reviewBtnPressed(_ sender: UIButton) {
        del?.didPressWriteReview()
    }
    
}
// MARK: - UICollectionViewDelegate
extension ProductDetailView: UICollectionViewDelegate { }
// MARK: - UICollectionViewDataSource
extension ProductDetailView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = reviewsCollectionView.dequeueReusableCell(withReuseIdentifier: C.reviewCellIdentifier, for: indexPath) as? ReviewCell else { return UICollectionViewCell() }
        let review = reviews[indexPath.row]
        cell.usernameLabel.text = review.username
        cell.rateLabel.text = "Rate: \(review.rate)/5"
        cell.reviewView.text = review.text
        return cell
    }
    
}
// MARK: - UICollectionViewDelegateFlowLayout
extension ProductDetailView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}
