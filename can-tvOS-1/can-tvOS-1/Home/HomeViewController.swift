//
//  HomeViewController.swift
//  can-tvOS-1
//
//  Created by Can Babaoğlu on 21.05.2022.
//

import UIKit

enum CellType: Int, CaseIterable {
    case carousal
    case latestVideos
    case classified
    case tools
}

class HomeViewController: UIViewController {

    @IBOutlet weak var homeDataTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    func setupTableView() {
        homeDataTableView.register(UINib.init(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoTableViewCellID")
        homeDataTableView.estimatedRowHeight = 300
        homeDataTableView.rowHeight = UITableView.automaticDimension
        homeDataTableView.delegate = self
        homeDataTableView.dataSource = self
        homeDataTableView.reloadData()
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: VideoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCellID", for: indexPath) as? VideoTableViewCell, let cellType = CellType(rawValue: indexPath.row) {
            cell.type = cellType
            switch cellType {
            case .carousal:
                    cell.titleLabel.isHidden = true
                    cell.videoCollectionViewHeightConstraint.constant = 540
            case .latestVideos:
                    cell.titleLabel.text = "Latest by Can"
                    cell.videoCollectionViewHeightConstraint.constant = 360
                    cell.delegate = self
            case .classified:
                    cell.titleLabel.text = "Classified"
                    cell.videoCollectionViewHeightConstraint.constant = 360
                    cell.videoCollectionView.reloadData()
            case .tools:
                    cell.titleLabel.text = "Useful Tools"
                    cell.videoCollectionViewHeightConstraint.constant = 300
                    cell.videoCollectionView.reloadData()
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension HomeViewController: VideoTableViewCellDelegate {
    func didSelectItem() {
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            self.present(detailVC, animated: true, completion: nil)
        }
    }
}
