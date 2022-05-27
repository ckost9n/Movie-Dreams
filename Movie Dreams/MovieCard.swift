//
//  MovieCard.swift
//  Movie Dreams
//
//  Created by Konstantin on 27.05.2022.
//

import UIKit

struct CategoryMovie {
    let name: String
    let movies: [MovieCard]
    
    static func getCategory() -> [CategoryMovie] {
        var categories: [CategoryMovie] = []
        categories = [
            CategoryMovie(name: "Popular Movie", movies: MovieCard.getFake()),
            CategoryMovie(name: "TV Show", movies: MovieCard.getFake()),
            CategoryMovie(name: "Anime", movies: MovieCard.getFake()),
            CategoryMovie(name: "Action", movies: MovieCard.getFake()),
            CategoryMovie(name: "Comedy", movies: MovieCard.getFake())
        ]
        return categories
    }
}

struct MovieCard {
    let name: String
    let imageData: Data?
    let date: Date
    let year: String?
    let star: Double?
    let description: String?
    let genre: String?
    let continueVideo: String?
    let acterList: [Acter]?
    var image: UIImage {
        let image = imageData != nil ? UIImage(data: imageData!)! : UIImage(named: "poster")!
        return image
    }
    
    init(name: String, date: Date) {
        self.name = name
        self.date = date
        imageData = nil
        year = nil
        star = nil
        description = nil
        genre = nil
        continueVideo = nil
        acterList = nil
    }
    
    static func getFake() -> [MovieCard] {
        var movies: [MovieCard] = []
        movies = [
            MovieCard(name: "Wonder Women", date: Date()),
            MovieCard(name: "Betmen", date: Date()),
            MovieCard(name: "Spider-Man", date: Date()),
            MovieCard(name: "Men in Black", date: Date()),
            MovieCard(name: "Halo", date: Date()),
            MovieCard(name: "Star Wars", date: Date()),
            MovieCard(name: "Alfa", date: Date())
        ]
        return movies
    }
}

struct Acter {
    let name: String
    let chareckter: String
    let imageData: Data?
    
    var image: UIImage {
        let image = imageData != nil ? UIImage(data: imageData!)! : UIImage(named: "poster")!
        return image
    }
}
