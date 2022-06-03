//
//  DetailMovieData.swift
//  Movie Dreams
//
//  Created by Илья Шаповалов on 03.06.2022.
//

import Foundation

struct DetailMovieData: Codable {
    let backdropPath: String
    let genres: [Genres]
    let homepage: String
    let originalTitle: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    let runtime: Int
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres = "genres"
        case homepage = "homepage"
        case originalTitle = "original_title"
        case overview = "overview"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime = "runtime"
        case id
    }
}

struct Genres: Codable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
