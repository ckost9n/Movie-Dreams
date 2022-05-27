//
//  MainViewController.swift
//  Movie Dreams
//
//  Created by Konstantin on 24.05.2022.
//

import UIKit

class MainViewController: UITableViewController {
    
    private let arryTest = ["Milk", "Bread", "Coffe"]
    
    private let videoArray = CategoryMovie.getCategory()
    
    private let network = Networking.shared
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setupNavigationBar(barColor: .darkBackgound, textColor: .red)
        navigationItem.title = "Movie Dreams"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    private func setupViews() {
        tableView.register(VideoListCell.self, forCellReuseIdentifier: VideoListCell.identifier)
        tableView.rowHeight = 300
        tableView.separatorStyle = .none
        view.backgroundColor = .darkBackgound
        
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoListCell.identifier, for: indexPath) as! VideoListCell
        cell.cellDelegate = self
        let model = videoArray[indexPath.row]
        cell.configureCell(model)
        
        return cell
    }

}

extension MainViewController: EventsCell {
    
    func didClick() {
        network.fetchUrl(category: .trendingAll)
//        let movieVC = MovieCardController()
//        movieVC.modalPresentationStyle = .fullScreen
//        movieVC.modalTransitionStyle = .crossDissolve
//        navigationController?.present(movieVC, animated: true)
    }

}

