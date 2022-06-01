//
//  MainViewController.swift
//  Movie Dreams
//
//  Created by Konstantin on 24.05.2022.
//

import UIKit

class MainViewController: UITableViewController {
    
    private let arryTest = ["Milk", "Bread", "Coffe"]
    
    private lazy var compareModel = CompareModel()
    
    private var movies: CategoryMovie?
    
    private var categories: [CategoryMovie] = []
    
    private let allCAtegories = Categories.allCases
    
    private let searchController = UISearchController()
    
    private var filterCategories: [CategoryMovie] = []
    
    private var isFiltering = false
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setupNavigationBar(barColor: .darkBackgound, textColor: .red)
        navigationItem.title = "Movie Dreams"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        for category in allCAtegories {
            compareModel.getMovieLists(category: category) { [weak self] categoryGet in
                guard let self = self else { return }
                guard let categoryMovie = categoryGet else { return }
                self.categories.append(categoryMovie)
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupViews() {
        tableView.register(VideoListCell.self, forCellReuseIdentifier: VideoListCell.identifier)
        tableView.rowHeight = 300
        tableView.separatorStyle = .none
        view.backgroundColor = .darkBackgound
        navigationItem.searchController = searchController
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoListCell.identifier, for: indexPath) as! VideoListCell
        cell.cellDelegate = self

        let category = categories[indexPath.row].name
        let model = isFiltering ? filterCategories[indexPath.row].movies : categories[indexPath.row].movies
        
        cell.configure(category, model: model)
        
        return cell
    }

}


extension MainViewController: EventsCell {
    func didClick(movie: MovieCard) {
//        print("-------")
        let name = movie.name ?? "No name!!!"
//        print(name)
//        print("-------")
        let movieVC = MovieCardController()

        movieVC.modalPresentationStyle = .popover
        movieVC.modalTransitionStyle = .coverVertical

        navigationController?.present(movieVC, animated: true)
    }
    
}

