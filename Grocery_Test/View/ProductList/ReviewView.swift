//
//  ReviewView.swift
//  Grocery_Test
//
//  Created by Денис Андриевский on 03.11.2020.
//

import UIKit

protocol ReviewViewDelegate: class {
    func doneBtnPressed(with rate: Int, text: String)
}

final class ReviewView: UIView {

    // MARK: - IBOutlets
    @IBOutlet var stars: [UIButton]!
    @IBOutlet private weak var reviewTextView: UITextView! {
        didSet {
            reviewTextView.delegate = self
        }
    }
    
    private var currentRate = 0
    weak var delegate: ReviewViewDelegate?
    
    @IBAction func doneBtnPressed(_ sender: UIButton) {
        delegate?.doneBtnPressed(with: currentRate, text: reviewTextView.text)
    }
    
    @IBAction func starBtnPressed(_ sender: UIButton) {
        currentRate = sender.tag
        for tag in 1...sender.tag {
            if let btn = self.viewWithTag(tag) as? UIButton {
                btn.setImage(UIImage(systemName: "star.fill"), for: .normal)
            }
        }
        if sender.tag == 5 {
            return
        }
        for tag in sender.tag+1...5 {
            if let btn = self.viewWithTag(tag) as? UIButton {
                btn.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
    }

}

extension ReviewView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
