//
//  MovieCardController.swift
//  Movie Dreams
//
//  Created by Eugene Kotovich on 24.05.2022.
//

import UIKit

class MovieCardController: UIViewController {
    
    //MARK: - interface Properties
    let posterView: UIImageView = {
        $0.image = UIImage(named: "poster")
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    let movieTitle: UILabel = {
        $0.text = "Pulp Fiction"
        $0.font = UIFont.boldSystemFont(ofSize: 30)
        $0.textAlignment = .center
        $0.textColor = .white
        return $0
    }(UILabel())
    
    let yearLabel: UILabel = {
        $0.text = "1994"
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .white
        return $0
    }(UILabel())
    
    let genreLabel: UILabel = {
        $0.text = "Thriller, Criminal"
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .white
        return $0
    }(UILabel())
    
    let longestLabel: UILabel = {
        $0.text = "2h 34m"
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .white
        return $0
    }(UILabel())
    
    let starRating: StarsView = {
        return $0
    }(StarsView())
    
    let rewievLabel: UILabel = {
        $0.text = "Двое бандитов Винсент Вега и Джулс Винфилд проводят время в философских беседах в перерыве между разборками и «решением проблем» с должниками своего криминального босса Марселласа Уоллеса. Параллельно разворачивается три истории. В первой из них Винсент присматривает за женой Марселласа Мией и спасает ее от передозировки наркотиков. Во второй рассказывается о Бутче Кулидже, боксере, нанятом Уоллесом, чтобы сдать бой, но обманувшим его."
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .white
        return $0
    }(UILabel())

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: - initialize subview's and constraints
    func initialize() {
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.addSubview(posterView)
        
        posterView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        posterView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        posterView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        posterView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(movieTitle)
        
        movieTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        movieTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
