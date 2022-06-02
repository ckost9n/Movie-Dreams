//
//  MainViewController.swift
//  Movie Dreams
//
//  Created by Konstantin on 24.05.2022.
//

import UIKit

class MainViewController: UITableViewController {
    
    private let arryTest = ["Milk", "Bread", "Coffe"]
    
    private lazy var network = Networking()
    
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
        
        //устанавливаем MainViewController делегатом для получение информации об обновлении текста в searchController
        searchController.searchResultsUpdater = self
        
        for category in allCAtegories {
            network.performRequest(category: category) { [weak self] categoryGet in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.categories.append(categoryGet)
                    self.tableView.reloadData()
                }
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
        
        // заполнение model фильтрованным или полным списком фильмов
        if isFiltering {
            return filterCategories.count
        } else {
            return categories.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoListCell.identifier, for: indexPath) as! VideoListCell
        
        cell.cellDelegate = self

        var category = Categories.trendingAllDay
        var model = [MovieCard]()
        
        // заполнение model фильтрованным или полным списком фильмов
        if isFiltering {
            category = filterCategories[indexPath.row].name
            model = filterCategories[indexPath.row].movies
        } else {
            category = categories[indexPath.row].name
            model = categories[indexPath.row].movies
        }
        
        //передаем данные о категории и кол-ве фильмов в ней
        cell.configure(category, model: model)
        
        return cell
    }
    
    // создание фильтрованного списка
    func createFilterCategory(for filterText: String) {
        filterCategories = [CategoryMovie]()
        var movieArray = [MovieCard]()
        // проходим по всем категориям
        for indexCategory in 0..<categories.count {
            // проходим по всем фильмам в текущей категории
            for indexMovie in 0..<categories[indexCategory].movies.count {
                // получаем имя фильма, которое будем проверять
                if let safeNameMovies = categories[indexCategory].movies[indexMovie].name {
                    // проверяем содержится ли текст пользователя в имени фильма, если да, то добавляем фильм в movieArray
                    if safeNameMovies.contains(filterText) {
                        movieArray.append(categories[indexCategory].movies[indexMovie])
                    }
                }
            }
            // добавляем категории с фильмами в которых найдены совпадения
            if !movieArray.isEmpty {
                filterCategories.append(CategoryMovie(name: categories[indexCategory].name, movies: movieArray))
            }
            movieArray = [MovieCard]()
        }
    }
}


extension MainViewController: EventsCell {
    func didClick(movie: MovieCard) {
        print("-------")
        let name = movie.name ?? "No name!!!"
        print(name)
        print("-------")
//        let movieVC = MovieCardController()
//        movieVC.modalPresentationStyle = .fullScreen
//        movieVC.modalTransitionStyle = .crossDissolve
//        navigationController?.present(movieVC, animated: true)
    }
    
}

// MARK: - UISearchResultsUpdating Delegate
extension MainViewController: UISearchResultsUpdating {
    // этот метод делегата вызывается каждый раз как редактируется текст в UISearchController()
    func updateSearchResults(for searchController: UISearchController) {
        // получаем текст из UISearchController()
        if let safeText = searchController.searchBar.text {
            if safeText == "" {
                isFiltering = false
                tableView.reloadData()
            } else {
                isFiltering = true
                //вызов метода по созданию фильтрованного списка
                createFilterCategory(for: safeText)
                tableView.reloadData()
            }
        }
    }
}
