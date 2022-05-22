//
//  VideoTableViewCell.swift
//  can-tvOS-1
//
//  Created by Can Babaoğlu on 21.05.2022.
//

import UIKit

protocol VideoTableViewCellDelegate: AnyObject {
    func didSelectItem()
}

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var videoCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var videoCollectionViewHeightConstraint: NSLayoutConstraint!
    
    weak var delegate: VideoTableViewCellDelegate?
    var type: CellType = .latestVideos
    
    var latestVideos = ["repo1","repo2","repo3","repo4","repo5","repo6"]
    var carousalVideos = ["tvOS_development","tvOS-limitations"]
    var classifiedVideos = ["Interviews", "Swift UI", "Core Concepts", "DSA"]
    var toolsVideos = ["simsim","instruments","pusher"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        videoCollectionView.delegate = self
        videoCollectionView.dataSource = self
        registerNibs()
    }
    
    func registerNibs() {
        videoCollectionView.register(UINib(nibName: "VideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideoCollectionViewCell")
        videoCollectionView.register(UINib(nibName: "ClassifiedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ClassifiedCollectionViewCell")
        videoCollectionView.register(UINib(nibName: "ToolsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ToolsCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension VideoTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch type {
        case .carousal:
            return carousalVideos.count
        case .latestVideos:
            return latestVideos.count
        case .classified:
            return classifiedVideos.count
        case .tools:
            return toolsVideos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch type {
        case .carousal:
            if let cell: VideoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as? VideoCollectionViewCell {
                cell.type = type
                cell.posterImageView.image = UIImage(named: carousalVideos[indexPath.row])
                cell.posterImageView.contentMode = .scaleAspectFill
                return cell
            }
            return UICollectionViewCell()
        case .latestVideos:
            if let cell: VideoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as? VideoCollectionViewCell {
                cell.type = type
                cell.posterImageView.image = UIImage(named: latestVideos[indexPath.row])
                return cell
            }
            return UICollectionViewCell()
        case .classified:
            if let cell: ClassifiedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassifiedCollectionViewCell", for: indexPath) as? ClassifiedCollectionViewCell {
                cell.configureView(text: classifiedVideos[indexPath.row])
                return cell
            }
            return UICollectionViewCell()
        case .tools:
            if let cell: ToolsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToolsCollectionViewCell", for: indexPath) as? ToolsCollectionViewCell {
                cell.posterImageView.image = UIImage(named: toolsVideos[indexPath.row])
                return cell
            }
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch type {
        case .carousal:
            return CGSize(width: collectionView.frame.size.width - 180, height: collectionView.frame.size.height)
        case .latestVideos, .tools:
            return CGSize(width: (16/9) * collectionView.frame.size.height, height: collectionView.frame.size.height)
        case .classified:
            return CGSize(width: 360, height: 360)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem()
    }
    
}
