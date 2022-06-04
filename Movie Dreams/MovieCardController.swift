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
    var movieName: String?
    //var currentMovie = MovieCard(name: "")
    
    private var fakeActor: [Actor] = []
    
//    guard model.posterUrl != nil else { return }
//    movieImgaView.downloaded(from: model.posterUrl!)
    
    //MARK: - Interface Elements
    private let posterView: UIImageView = {
        $0.image = UIImage(named: "poster")
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let movieTitle: UILabel = {
        $0.text = "Pulp Fiction"
        $0.font = UIFont.boldSystemFont(ofSize: 30)
        $0.textAlignment = .center
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let movieSubTitle: UILabel = {
        $0.text = "1994" + " * " + "Thriller, Criminal" + " * " + "2h 34m"
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let starRatingView = StarRatingView()
    
    private let castActorView = CastActorView()
    
    private let actorCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .darkBackgound
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let rewievLabel: UILabel = {
        $0.text = "Двое бандитов Винсент Вега и Джулс Винфилд проводят время в философских беседах в перерыве между разборками и «решением проблем» с должниками своего криминального босса Марселласа Уоллеса. Параллельно разворачивается три истории. В первой из них Винсент присматривает за женой Марселласа Мией и спасает ее от передозировки наркотиков. Во второй рассказывается о Бутче Кулидже, боксере, нанятом Уоллесом, чтобы сдать бой, но обманувшим его."
        $0.font = UIFont.systemFont(ofSize: 15)
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
    
    private let addFavoriteButton: UIButton = {
        let button = UIButton(type: .system)
        
        //устанавливаем иконку bookmark в зависимости от статуса favoriteMovie у фильма
        if GeneralProperties.currentMovie.favoriteMovie == false {
            button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }
        
        button.tintColor = .white
        button.addTarget(self, action: #selector(addFavoriteButtonTapped), for: .touchUpInside)
//        button.addTarget(self, action: #selector(addFavoriteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let watchNowButton: UIButton = {
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
        setConstrains()
        fakeActor = Actor.getActor()
        
    }
    
    //MARK: - Privat Properties
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
//        view.addSubview(castActorView)
        view.addSubview(watchNowButton)
        actorCollectionView.register(
            AtorCollectionViewCell.self,
            forCellWithReuseIdentifier: AtorCollectionViewCell.collectionId
        )
        view.addSubview(actorCollectionView)
    }
    
    private func setDelegates() {
        actorCollectionView.delegate = self
        actorCollectionView.dataSource = self
        
    }
    
}

extension MovieCardController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 20
        fakeActor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AtorCollectionViewCell.collectionId, for: indexPath) as! AtorCollectionViewCell
//        let model = fakeActor[0]
        let model = fakeActor[indexPath.row]
        cell.configure(model: model)
        
        return cell
    }
    
    

}

//MARK: - NSLayoutConstraint
extension MovieCardController {
    
    private func setConstrains() {
        //Constraints for posterView
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: view.topAnchor),
            posterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterView.heightAnchor.constraint(equalToConstant: view.frame.height / 2.5)
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
            movieTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
            rewievLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
        //Constraints for castActorView
//        NSLayoutConstraint.activate([
//            castActorView.topAnchor.constraint(equalTo: rewievLabel.bottomAnchor),
//            castActorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            castActorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            castActorView.bottomAnchor.constraint(equalTo: watchNowButton.topAnchor)
//        ])
        
        NSLayoutConstraint.activate([
            actorCollectionView.topAnchor.constraint(equalTo: rewievLabel.bottomAnchor),
            actorCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            actorCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            actorCollectionView.bottomAnchor.constraint(equalTo: watchNowButton.topAnchor)
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

