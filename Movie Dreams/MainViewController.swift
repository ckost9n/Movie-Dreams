//
//  MainViewController.swift
//  Movie Dreams
//
//  Created by Konstantin on 24.05.2022.
//

import UIKit

class MainViewController: UITableViewController {
    
    private let arryTest = ["Milk", "Bread", "Coffe"]
    
    override func viewWillAppear(_ animated: Bool) {
        let color = #colorLiteral(red: 0.1764705882, green: 0.1568627451, blue: 0.2078431373, alpha: 1)
        navigationController?.navigationBar.setupNavigationBar(barColor: color, textColor: .red)
        navigationItem.title = "Movie Dreams"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        tableView.register(VideoListCell.self, forCellReuseIdentifier: VideoListCell.identifier)
        tableView.rowHeight = 300

    }
    
    // MARK: - Table view data source


//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arryTest.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoListCell.identifier, for: indexPath) as! VideoListCell
        
        let model = arryTest[indexPath.row]
        cell.configureCell(model)
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoVC = InfoViewController()
        infoVC.modalPresentationStyle = .fullScreen
        infoVC.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(infoVC, animated: true)
    }

    
}

