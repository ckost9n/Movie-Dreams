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
                    id: movie.id,
                    mediaType: movie.mediaType.rawValue
                )
                movies.append(newMovie)
            }
            let categoryMovie = CategoryMovie(name: category, movies: movies)
            completion(categoryMovie)
        }
    }
    // Get selected movie by id
    func getMovie(ofType type: String, withId id: Int, completion: @escaping (DetailMovieCard?) -> Void) {
        
        dataFetcherService.fetchData(ofType: type, withId: id) { decodeData in
            guard let movie = decodeData else { return }
            let newMovie = DetailMovieCard(originalTitle: movie.originalTitle ?? movie.originalName ?? movie.name,
                                           backdropPath: movie.backdropPath,
                                           overview: movie.overview,
                                           releaseDate: movie.releaseDate ?? movie.firstAirDate,
                                           runtime: movie.runtime,
                                           episodeRunTime: movie.episodeRunTime ?? [],
                                           homepage: movie.homepage,
                                           genres: movie.genres
            )
            completion(newMovie)
        }
    }
    // Get actor cast from selected movie by id
    func getCast(ofType type: String, with id: Int, completion: @escaping (DetailCreditsCard?) -> Void) {
        
        dataFetcherService.fetchCreditsData(ofType: type, withId: id) { decodeData in
            guard let castList = decodeData?.credits else { return }
            var actors: [CastList] = []
            for actor in castList {
                let newActor = CastList(name: actor.name ?? actor.originalName,
                                        character: actor.character,
                                        profilePath: actor.profilePath
                )
                actors.append(newActor)
            }
            let detailCreditsCard = DetailCreditsCard(cast: actors)
            completion(detailCreditsCard)
        }
    }
}
