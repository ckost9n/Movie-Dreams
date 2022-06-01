//
//  MovieCard.swift
//  Movie Dreams
//
//  Created by Konstantin on 27.05.2022.
//

import UIKit

struct CategoryMovie {
    let name: Categories
    let movies: [MovieCard]
}

struct MovieCard {
    let name: String?
    let posterString: String?
    let backdropString: String?
    let dateString: String?
    
    let star: Double?
    let description: String?
    
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
    
    init(name: String?, posterString: String, backdropString: String?, dateString: String?, star: Double?, description: String?) {
        self.name = name
        self.posterString = posterString
        self.backdropString = backdropString
        self.dateString = dateString
        self.star = star
        self.description = description
    }
    
    init(name: String) {
        self.name = name
        
        posterString = nil
        backdropString = nil
        dateString = nil
        
        star = nil
        description = nil
        
    }
    
}

struct Actor {
    let name: String
    let chareckter: String
    let imageData: Data?
    
    var image: UIImage {
        let image = imageData != nil ? UIImage(data: imageData!)! : UIImage(named: "poster")!
        return image
    }
}
