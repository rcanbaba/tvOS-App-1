//
//  VideoCollectionViewCell.swift
//  can-tvOS-1
//
//  Created by Can Babaoğlu on 21.05.2022.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    
    var type: CellType = .latestVideos
    
    override func awakeFromNib() {
        super.awakeFromNib()        
        posterImageView.layer.cornerRadius = 20.0
        posterImageView.clipsToBounds = true
        posterImageView.layer.borderWidth = 10.0
        posterImageView.layer.borderColor = UIColor.clear.cgColor
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({ [weak self] in
            if self?.isFocused ?? false {
                self?.posterImageView.transform = self?.type == .carousal ? CGAffineTransform(scaleX: 1.01, y: 1.01) : CGAffineTransform(scaleX: 1.05, y: 1.05)
                self?.posterImageView.layer.borderColor = UIColor.white.cgColor
            } else {
                self?.posterImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self?.posterImageView.layer.borderColor = UIColor.clear.cgColor
            }
        }, completion: nil)
    }
}
