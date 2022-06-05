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
    
    var currentMovie: MovieCard?
    let webViewController = WebViewController()
    var movieName: String?
    
    //MARK: - Private Properties
    private lazy var compareModel = CompareModel()
    private lazy var starsView = StarsView()
    private var newActor: [CastList] = []
    
    //MARK: - Interface Elements
    private let posterView: UIImageView = {
        $0.image = UIImage(named: "poster")
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let movieTitle: UILabel = {
        $0.text = "Pulp Fiction"
        $0.shadowColor = .black
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
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let ratingLabel: UILabel = {
        $0.text = "0.0"
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .yellow
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let actorCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 70, height: 90)
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .darkBackgound
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let rewievLabel: UILabel = {
        $0.text = "Двое бандитов Винсент Вега и Джулс Винфилд проводят время в философских беседах в перерыве между разборками и «решением проблем» с должниками своего криминального босса Марселласа Уоллеса. Параллельно разворачивается три истории. В первой из них Винсент присматривает за женой Марселласа Мией и спасает ее от передозировки наркотиков. Во второй рассказывается о Бутче Кулидже, боксере, нанятом Уоллесом, чтобы сдать бой, но обманувшим его."
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.8
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
        
        //устанавливаем иконку bookmark в зависимости от статуса favoriteMovie у фильма
        if GeneralProperties.currentMovie.favoriteMovie == false {
            button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }
        
        button.tintColor = .white
        button.addTarget(self, action: #selector(addFavoriteButtonTapped), for: .touchUpInside)
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
        setDelegates()
        setupViews()
        setupConstrains()
        setupData()
    }
    
    //MARK: - Private Properties
    @objc private func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc private func addFavoriteButtonTapped(_ sender: UIButton) {
        //меняем иконку bookmark и меняем статус favoriteMovie у фильма
        if addFavoriteButton.currentImage == UIImage(systemName: "bookmark.fill") {
            addFavoriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            GeneralProperties.currentMovie.favoriteMovie = false
        } else {
            addFavoriteButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            GeneralProperties.currentMovie.favoriteMovie = true
        }
    }
    
    @objc private func watchNowButtonTapped(_ sender: UIButton) {
        webViewController.modalPresentationStyle = .fullScreen
        webViewController.modalTransitionStyle = .crossDissolve
        present(webViewController, animated: true)
    }
    
    //MARK: - setupViews()
    private func setupViews() {
        view.backgroundColor = .darkBackgound
        view.addSubview(posterView)
        view.addSubview(closeButton)
        view.addSubview(addFavoriteButton)
        view.addSubview(movieTitle)
        view.addSubview(movieSubTitle)
        view.addSubview(starsView)
        view.addSubview(ratingLabel)
        view.addSubview(rewievLabel)
        view.addSubview(watchNowButton)
        actorCollectionView.register(
            ActorCollectionViewCell.self,
            forCellWithReuseIdentifier: ActorCollectionViewCell.collectionId
        )
        view.addSubview(actorCollectionView)
    }
    
    private func setDelegates() {
        actorCollectionView.delegate = self
        actorCollectionView.dataSource = self
        
    }
    
    //MARK: - Fetch data for selected movie
    func setupData() {
        guard let unwrappedId = currentMovie?.id else { return }
        guard let unwrappedMediaType = currentMovie?.mediaType else { return }
        print(unwrappedId)
        print(unwrappedMediaType)
        // .getMovie fetcher get information aboult movie: poster, title, review, rating, etc...
        compareModel.getMovie(ofType: unwrappedMediaType, withId: unwrappedId) { [weak self] movieGet in
            guard let self = self else { return }
            guard let unwrappedMovie = movieGet else { return }
            self.webViewController.webSite = unwrappedMovie.homepage
            self.configureMovieCard(model: unwrappedMovie)
        }
        // .getCast fetcher get information aboult cast: actor's name, character name and URL-path of portrait
        compareModel.getCast(ofType: unwrappedMediaType, with: unwrappedId) { [weak self] castGet in
            guard let self = self else { return }
            guard let unwrappedCast = castGet else { return }
            self.newActor = unwrappedCast.cast
            self.actorCollectionView.reloadData()
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
        self.ratingLabel.text = String(model.rating)
        self.starsView.rating = Int(model.rating)
    }
    
}

extension MovieCardController: UINavigationBarDelegate {
    
}

extension MovieCardController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        newActor.count
//      fakeActor.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorCollectionViewCell.collectionId, for: indexPath) as! ActorCollectionViewCell
        let model = newActor[indexPath.row]
        cell.configure(model: model)
        
        return cell
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
            movieTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height / 70),
            movieTitle.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8)
        ])
        //Constraints for movieSubTitle
        NSLayoutConstraint.activate([
            movieSubTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieSubTitle.topAnchor.constraint(equalTo: movieTitle.bottomAnchor),
            movieSubTitle.heightAnchor.constraint(equalToConstant: 30)
        ])
        //Constraints for starRatingView
        starsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starsView.topAnchor.constraint(equalTo: movieSubTitle.bottomAnchor, constant: 5),
            starsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            starsView.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            starsView.heightAnchor.constraint(equalToConstant: 20)
        ])
        //Constrains for ratingLabel
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: movieSubTitle.bottomAnchor, constant: 5),
            ratingLabel.widthAnchor.constraint(equalToConstant: 40),
            ratingLabel.heightAnchor.constraint(equalToConstant: 20),
            ratingLabel.trailingAnchor.constraint(equalTo: starsView.leadingAnchor, constant: 5)
        ])
        //Constraints for rewievLabel
        NSLayoutConstraint.activate([
            rewievLabel.topAnchor.constraint(equalTo: starsView.bottomAnchor, constant: 5),
            rewievLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            rewievLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            rewievLabel.bottomAnchor.constraint(equalTo: actorCollectionView.topAnchor, constant: 5)
        ])
        //Constraints for actorCollectionView
        NSLayoutConstraint.activate([
            actorCollectionView.heightAnchor.constraint(equalToConstant: view.frame.height / 8),
            actorCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            actorCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            actorCollectionView.bottomAnchor.constraint(equalTo: watchNowButton.topAnchor)
            
        ])
        //Constraints for watchNowButton
        NSLayoutConstraint.activate([
            watchNowButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            watchNowButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            watchNowButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            watchNowButton.heightAnchor.constraint(equalToConstant: view.frame.height / 20)
        ])
    }
}

