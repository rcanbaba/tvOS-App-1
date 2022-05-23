//
//  DetailViewController.swift
//  can-tvOS-1
//
//  Created by Can Babaoğlu on 23.05.2022.
//

import UIKit

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
