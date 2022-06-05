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
    let homepage: String?
    let originalTitle, name, originalName: String?
    let overview: String
    let posterPath: String
    let releaseDate, firstAirDate: String?
    let runtime: Int?
    let episodeRunTime: [Int]?
    let id: Int
    let voteAverage: Float
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres = "genres"
        case homepage = "homepage"
        case originalTitle = "original_title"
        case name = "name"
        case originalName = "original_name"
        case overview = "overview"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
        case runtime = "runtime"
        case episodeRunTime = "episode_run_time"
        case voteAverage = "vote_average"
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
