//
//  DetailMovieCard.swift
//  Movie Dreams
//
//  Created by Илья Шаповалов on 03.06.2022.
//

import Foundation

struct DetailMovieCard {
    let backdropPath: String?
    let genres: [Genres]?        // Array of type [Movie_Dreams.Genres(id: 28, name: "Action")]
    let homepage: String?
    let originalTitle: String?
    let overview: String?
    let releaseDate: String?     // Return string of type "2022-04-06"
    let runtime: Int?            // Return number of minutes
    let episodeRunTime: [Int]?   // Retur array of minutes
    let rating: Float
    // Calculatted variable for getting URL-String of background poster
    var backdropURL: String? {
        guard backdropPath != nil else { return nil }
        return "https://image.tmdb.org/t/p/original" + (self.backdropPath ?? "")
    }
    // Method return string of type "Action,Adventure,...," always with comma in the end. Should use .dropLast() then using this method
    func getGenres() -> String {
        var genresString = ""
        if genres != nil {
            for genre in genres! {
                genresString += genre.name.appending(",")
            }
            return genresString
        } else {
            return "Can't get genres!"
        }
    }
    // Method conwert runtime from "150" to "2h30min" format
    func getRunTime() -> String {
        if runtime != nil {
            return "\(String(runtime! / 60))h\(String(runtime! % 60))min"
        } else {
            return "\(String(episodeRunTime?[0] ?? 0))min"
        }
    }
    //MARK: - init()
    init(originalTitle: String?,
         backdropPath: String?,
         overview: String?,
         releaseDate: String?,
         runtime: Int?,
         episodeRunTime: [Int],
         homepage: String?,
         genres: [Genres]?,
         rating: Float
    ) {
        self.originalTitle = originalTitle
        self.backdropPath = backdropPath
        self.overview = overview
        self.releaseDate = releaseDate
        self.runtime = runtime
        self.episodeRunTime = episodeRunTime
        self.homepage = homepage
        self.genres = genres
        self.rating = rating
    }
}
