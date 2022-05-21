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
    
}
