//
//  ReviewCell.swift
//  Grocery_Test
//
//  Created by Денис Андриевский on 03.11.2020.
//

import UIKit

final class ReviewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var reviewView: UITextView! {
        didSet {
            reviewView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            reviewView.textContainer.lineFragmentPadding = 0
        }
    }
    @IBOutlet private weak var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 20
        }
    }
    
}
