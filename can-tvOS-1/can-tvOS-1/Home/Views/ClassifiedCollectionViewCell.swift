//
//  ClassifiedCollectionViewCell.swift
//  can-tvOS-1
//
//  Created by Can Babaoğlu on 21.05.2022.
//

import UIKit

class ClassifiedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = containerView.frame.size.height / 2
        containerView.clipsToBounds = true
        containerView.backgroundColor = .random
        containerView.layer.borderWidth = 10.0
        containerView.layer.borderColor = UIColor.clear.cgColor
    }
    
    func configureView(text: String) {
        containerView.backgroundColor = UIColor.random
        titleLabel.text = text
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0.65...1), green: .random(in: 0.65...1), blue: .random(in: 0.65...1), alpha: 0.8)
    }
}
