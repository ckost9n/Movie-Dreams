//
//  CompareModel.swift
//  Movie Dreams
//
//  Created by Konstantin on 01.06.2022.
//

import Foundation

class CompareModel {
    var dataFetcherService: DataFetcherService!
    
    init(dataFetcherService: DataFetcherService = DataFetcherService()) {
        self.dataFetcherService = dataFetcherService
    }
    // Get lists of movies define by categories
    func getMovieLists(category: Categories, completion: @escaping (CategoryMovie?) -> Void) {
        
        dataFetcherService.fetchData(category: category) { decodeData in
            guard let movieList = decodeData?.results else { return }
            var movies: [MovieCard] = []
            for movie in movieList {
                let newMovie = MovieCard(
                    name: movie.name ?? movie.title,
                    posterString: movie.posterPath,
                    backdropString: movie.backdropPath,
                    dateString: movie.releaseDate ?? movie.firstAirDate,
                    star: movie.voteAverage,
                    description: movie.overview,
                    id: movie.id
                )
                movies.append(newMovie)
            }
            let categoryMovie = CategoryMovie(name: category, movies: movies)
            completion(categoryMovie)
        }
    }
    // Get chosen movie by id
    func getMovie(withId id: Int, completion: @escaping (DetailMovieCard?) -> Void) {
        
        dataFetcherService.fetchMovieData(withId: id) { decodeData in
            guard let movie = decodeData else { return }
            let newMovie = DetailMovieCard(originalTitle: movie.originalTitle,
                                           backdropPath: movie.backdropPath,
                                           overview: movie.overview,
                                           releaseDate: movie.releaseDate,
                                           runtime: movie.runtime,
                                           homepage: movie.homepage
            )
            completion(newMovie)
            
        }
    }
}
