//
//  MovieCardController.swift
//  Movie Dreams
//
//  Created by Eugene Kotovich on 24.05.2022.
//  Created by Илья Шаповалов on 30.05.2022.
//

import UIKit

class MovieCardController: UIViewController {
    
    //MARK: - Public Properties
    var movieId: Int?
    
    //MARK: - Interface Elements
    private let posterView: UIImageView = {
        $0.image = UIImage(named: "poster")
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let movieTitle: UILabel = {
        $0.text = "Pulp Fiction"
        $0.numberOfLines = 2
        $0.font = UIFont.boldSystemFont(ofSize: 30)
        $0.minimumScaleFactor = 0.5
        $0.textAlignment = .center
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let movieSubTitle: UILabel = {
        $0.text = "1994 * Thriller, Criminal * 2h 34m"
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var starRatingView = StarRatingView()
    private lazy var castActorView = CastActorView()
    private lazy var compareModel = CompareModel()
    
    private let rewievLabel: UILabel = {
        $0.text = "Двое бандитов Винсент Вега и Джулс Винфилд проводят время в философских беседах в перерыве между разборками и «решением проблем» с должниками своего криминального босса Марселласа Уоллеса. Параллельно разворачивается три истории. В первой из них Винсент присматривает за женой Марселласа Мией и спасает ее от передозировки наркотиков. Во второй рассказывается о Бутче Кулидже, боксере, нанятом Уоллесом, чтобы сдать бой, но обманувшим его."
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.minimumScaleFactor = 0.5
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    
    //MARK: - Buttons
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .white
        button.addTarget(self,
                         action: #selector(closeButtonTapped),
                         for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var addFavoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .white
        button.addTarget(self,
                         action: #selector(addFavoriteButtonTapped),
                         for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var watchNowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Watch Now", for: .normal)
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.backgroundColor = .red
        button.addTarget(self,
                         action: #selector(watchNowButtonTapped),
                         for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstrains()
        setupData()
        
        
    }
    
    //MARK: - Private Properties
    @objc private func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc private func addFavoriteButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc private func watchNowButtonTapped(_ sender: UIButton) {
        
    }
    
    //MARK: - setupViews()
    private func setupViews() {
        view.backgroundColor = .darkBackgound
        view.addSubview(posterView)
        view.addSubview(closeButton)
        view.addSubview(addFavoriteButton)
        view.addSubview(movieTitle)
        view.addSubview(movieSubTitle)
        view.addSubview(starRatingView)
        view.addSubview(rewievLabel)
        view.addSubview(castActorView)
        view.addSubview(watchNowButton)
    }
    
    //MARK: - <#Section Header#>
    func setupData() {
        guard let unwrappedId = movieId else { return }
        compareModel.getMovie(withId: unwrappedId) { [weak self] movieGet in
            guard let self = self else { return }
            guard let unwrappedMovie = movieGet else { return }
            self.configureMovieCard(model: unwrappedMovie)
        }
        
    }
    //MARK: - configureMovieCard elements
    //Set properties from downloaded model to interface elements
    func configureMovieCard(model: DetailMovieCard) {
        //Set image to poster view
        guard let unwrappedBackdrop = model.backdropURL else { return }
        self.posterView.downloaded(from: unwrappedBackdrop, contentMode: .scaleAspectFill)
        //Set movie name to movieTitle label
        self.movieTitle.text = model.originalTitle
        //Set information to moviewSubTitle label in format: "year * genre * duration"
        guard let unwrappedDate = model.releaseDate else { return }
        let movieYear = unwrappedDate.prefix(4)
        self.movieSubTitle.text = movieYear + "*" + model.getGenres().dropLast() + "*" + model.getRunTime()
        //Set description to rewievLabel
        self.rewievLabel.text = model.overview
    }
    
    
}

//MARK: - NSLayoutConstraint
extension MovieCardController {
    
    private func setupConstrains() {
        //Constraints for posterView
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: view.topAnchor),
            posterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterView.heightAnchor.constraint(equalToConstant: view.frame.height / 2)
        ])
        //Constraints for addFavoriteButton
        NSLayoutConstraint.activate([
            addFavoriteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addFavoriteButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            addFavoriteButton.widthAnchor.constraint(equalToConstant: 60),
            addFavoriteButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        //Constraints for closeButton
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 60),
            closeButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        //Constraints for movieTitle
        NSLayoutConstraint.activate([
            movieTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            movieTitle.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8)
        ])
        //Constraints for movieSubTitle
        NSLayoutConstraint.activate([
            movieSubTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieSubTitle.topAnchor.constraint(equalTo: movieTitle.bottomAnchor),
            movieSubTitle.heightAnchor.constraint(equalToConstant: 30)
        ])
        //Constraints for starRatingView
        NSLayoutConstraint.activate([
            starRatingView.topAnchor.constraint(equalTo: movieSubTitle.bottomAnchor, constant: 5),
            starRatingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            starRatingView.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            starRatingView.heightAnchor.constraint(equalToConstant: 30)
        ])
        //Constraints for rewievLabel
        NSLayoutConstraint.activate([
            rewievLabel.topAnchor.constraint(equalTo: starRatingView.bottomAnchor, constant: 5),
            rewievLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            rewievLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            rewievLabel.bottomAnchor.constraint(equalTo: castActorView.topAnchor, constant: 5)
        ])
        //Constraints for castActorView
        NSLayoutConstraint.activate([
            castActorView.heightAnchor.constraint(equalToConstant: view.frame.height / 10),
            castActorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            castActorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            castActorView.bottomAnchor.constraint(equalTo: watchNowButton.topAnchor)
        ])
        //Constraints for watchNowButton
        NSLayoutConstraint.activate([
            watchNowButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            watchNowButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            watchNowButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            watchNowButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
