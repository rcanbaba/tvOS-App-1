//
//  DetailViewController.swift
//  can-tvOS-1
//
//  Created by Can Babaoğlu on 23.05.2022.
//

import UIKit
import AVKit

class DetailViewController: UIViewController {

    @IBOutlet weak var similarTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        similarTableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoTableViewCellID")
        similarTableView.estimatedRowHeight = 300
        similarTableView.rowHeight = UITableView.automaticDimension
        similarTableView.reloadData()
    }
    
    @IBAction func didClickOnPlayButton(_ sender: UIButton) {
        //Put any video in Resources directory, replace "Debugging" with it's name. I haven't pushed this video.
        guard let path = Bundle.main.path(forResource: "test123", ofType:"mp4") else {
            debugPrint("video.mp4 not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        
        playerController.player = player
        playerController.player?.currentItem?.externalMetadata = makeExternalMetadata()
        present(playerController, animated: true) {
            player.play()
        }
    }
    
    func makeExternalMetadata() -> [AVMetadataItem] {
        var metadata = [AVMetadataItem]()
        
        // Build title item
        let titleItem = makeMetadataItem(.commonIdentifierTitle, value: "Improve your Debugging Skills")
        metadata.append(titleItem)
        
        // Build artwork item
        if let image = UIImage(named: "repo1"), let pngData = image.pngData() {
            let artworkItem = makeMetadataItem(.commonIdentifierArtwork, value: pngData)
            metadata.append(artworkItem)
        }
        
        // Build description item
        let descItem = makeMetadataItem(.commonIdentifierDescription, value: """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nulla aliquet porttitor lacus luctus accumsan tortor posuere ac ut. Ridiculus mus mauris vitae ultricies leo integer malesuada. Tortor at risus viverra adipiscing at.
            """
        )
        metadata.append(descItem)
        
        // Build genre item
        let genreItem = makeMetadataItem(.quickTimeMetadataGenre, value: "Education")
        metadata.append(genreItem)
        return metadata
    }
    
    private func makeMetadataItem(_ identifier: AVMetadataIdentifier, value: Any) -> AVMetadataItem {
        let item = AVMutableMetadataItem()
        item.identifier = identifier
        item.value = value as? NSCopying & NSObjectProtocol
        item.extendedLanguageTag = "und"
        return item.copy() as! AVMetadataItem
    }

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: VideoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCellID", for: indexPath) as? VideoTableViewCell {
            cell.type = .latestVideos
            cell.latestVideos.removeFirst()
            cell.titleLabel.text = "You May Like"
            cell.videoCollectionViewHeightConstraint.constant = 200
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
