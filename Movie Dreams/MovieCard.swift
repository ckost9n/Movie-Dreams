//
//  MovieCard.swift
//  Movie Dreams
//
//  Created by Konstantin on 27.05.2022.
//

import UIKit

struct CategoryMovie {
    let name: Categories
    var movies: [MovieCard]
}

struct MovieCard {
    let name: String?
    let posterString: String?
    let backdropString: String?
    let dateString: String?
    var favoriteMovie: Bool = false
    let mediaType: String?
    let star: Double?
    let description: String?
    let id: Int?
    
    var posterUrl: String? {
        guard posterString != nil else { return nil }
        return "https://image.tmdb.org/t/p/w500/" + (self.posterString ?? "")
    }
    
    var backdorURL: String? {
        guard backdropString != nil else { return nil }
        return "https://image.tmdb.org/t/p/w500/" + (self.backdropString ?? "")
    }
    
    var imagePoster: UIImage {
        return UIImage(named: "poster")!
    }
    
    var imageBackdor: UIImage {
        return UIImage(named: "poster")!
    }
    
    init(name: String?, posterString: String, backdropString: String?, dateString: String?, star: Double?, description: String?, id: Int?, mediaType: String?) {
        self.name = name
        self.posterString = posterString
        self.backdropString = backdropString
        self.dateString = dateString
        self.star = star
        self.description = description
        self.id = id
        self.mediaType = mediaType
    }
    
    init(name: String) {
        self.name = name
        posterString = nil
        backdropString = nil
        dateString = nil
        star = nil
        description = nil
        id = nil
        mediaType = nil
    }
    
}

struct Actor {
    let name: String
    let chareckter: String
    let imageString = "https://api.themoviedb.org/3/movie/{movie_id}/credits?api_key=<<api_key>>&language=en-US"
    
    var image: UIImage {
        return UIImage(named: "poster")!
    }
    
    static func getActor() -> [Actor] {
        let actories = [
            Actor(name: "Liza", chareckter: "Woomen"),
            Actor(name: "Sveta", chareckter: "Girl"),
            Actor(name: "Konstantin", chareckter: "Dark"),
            Actor(name: "Artem", chareckter: "Graf")
        ]
        return actories
    }
}

