//
//  DetailMovieCard.swift
//  Movie Dreams
//
//  Created by Илья Шаповалов on 03.06.2022.
//

import Foundation

struct DetailMovieCard {
    let backdropPath: String?
//    let genres: [Genres]
    let homepage: String?
    let originalTitle: String?
    let overview: String?
    let releaseDate: String?
    let runtime: Int?
    
    var backdropURL: String? {
        guard backdropPath != nil else { return nil }
        return "https://image.tmdb.org/t/p/w500" + (self.backdropPath ?? "")
    }
    
    init(originalTitle: String?, backdropPath: String?, overview: String?, releaseDate: String?, runtime: Int?, homepage: String?) {
        self.originalTitle = originalTitle
        self.backdropPath = backdropPath
        self.overview = overview
        self.releaseDate = releaseDate
        self.runtime = runtime
        self.homepage = homepage
    }
}
