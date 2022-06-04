//
//  MainViewController.swift
//  Movie Dreams
//
//  Created by Konstantin on 24.05.2022.
//

import UIKit

class MainViewController: UITableViewController {
    
    //MARK: - Private Properties
    
    private let arryTest = ["Milk", "Bread", "Coffe"]
    
    private lazy var compareModel = CompareModel()
    
    private var movies: CategoryMovie?
    
    private var categories: [CategoryMovie] = []
    
    private let allCAtegories = Categories.allCases
    
    private let searchController = UISearchController()
    
    private var filterCategories: [CategoryMovie] = []
    
    private var isFiltering = false
    
    //MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setupNavigationBar(barColor: .darkBackgound, textColor: .red)
        navigationItem.title = "Movie Dreams"
        changeFavoriteMovies()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        //устанавливаем MainViewController делегатом для получение информации об обновлении текста в searchController
        searchController.searchResultsUpdater = self
        
        for category in allCAtegories {
            compareModel.getMovieLists(category: category) { [weak self] categoryGet in
                guard let self = self else { return }
                guard let categoryGet = categoryGet else { return }
                
                self.categories.append(categoryGet)
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Private Properties
    
    private func setupViews() {
        tableView.register(VideoListCell.self, forCellReuseIdentifier: VideoListCell.identifier)
        tableView.rowHeight = 300
        tableView.separatorStyle = .none
        view.backgroundColor = .darkBackgound
        navigationItem.searchController = searchController
    }
    
    //метод добавляет или удаляет фильмы из категории continueMovie
    private func changeFavoriteMovies() {
        // добавляем категорию continueMovie, если она не существует
        if categories.filter({$0.name == .continueMovie}).isEmpty {
            categories.append(CategoryMovie(name: .continueMovie, movies: [MovieCard]()))
        }
        // добавляем фильм в категорию continueMovie, если стоит статус на добавление
        if GeneralProperties.currentMovie.favoriteMovie {
            for indexCategory in 0..<categories.count {
                if categories[indexCategory].name == .continueMovie {
                    if categories[indexCategory].movies.filter({$0.name == GeneralProperties.currentMovie.name}).isEmpty {
                        categories[indexCategory].movies.append(GeneralProperties.currentMovie)
                    }
                }
            }
        }
        // удаляем фильм из категории continueMovie, если стоит статус на удаление
        else {
            var array = [MovieCard]()
            for indexCategory in 0..<categories.count {
                if categories[indexCategory].name == .continueMovie {
                    array = categories[indexCategory].movies.filter({$0.name != GeneralProperties.currentMovie.name})
                    categories[indexCategory].movies = array
                }
            }
        }
        // удаляем категорию continueMovie, если она не содержит фильмы
        for indexCategory in 0..<categories.count {
            if categories[indexCategory].name == .continueMovie {
                if categories[indexCategory].movies.isEmpty {
                    categories.remove(at: indexCategory)
                }
            }
        }
        // перезагружаю таблицу после изменения категории continueMovie
        tableView.reloadData()
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
            print(category.rawValue)
            model = filterCategories[indexPath.row].movies
        } else {
            category = categories[indexPath.row].name
            print(category.rawValue)
            model = categories[indexPath.row].movies
        }
        
        // передаем данные о категории и кол-ве фильмов в ней
        cell.configure(category, model: model)
        
        return cell
    }
}

// MARK: - Extension EventsCell

extension MainViewController: EventsCell {
    func didClick(movie: MovieCard) {
        
        // устанавливаю текущий фильм, что бы его мог использовать MovieCardController
        GeneralProperties.currentMovie = movie
        
        // устанавливаю статус favoriteMovie у текущего фильма
        for indexCategory in 0..<categories.count {
            if categories[indexCategory].name == .continueMovie {
                if categories[indexCategory].movies.filter({$0.name == movie.name}).isEmpty {
                    GeneralProperties.currentMovie.favoriteMovie = false
                } else {
                    GeneralProperties.currentMovie.favoriteMovie = true
                }
            }
        }
        
        let movieVC = MovieCardController()
        movieVC.modalPresentationStyle = .fullScreen
        movieVC.modalTransitionStyle = .crossDissolve

        navigationController?.present(movieVC, animated: true)
    }
}

// MARK: - Extension UISearchResultsUpdating

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

