//
//  Networking.swift
//  Movie Dreams
//
//  Created by Konstantin on 27.05.2022.
//

import Foundation

enum Categories: String, CaseIterable {
    case trendingAllDay = "All Trend in day"
    case trendingAllWeek = "All Trend in week"
    case trendingMovieDay = "Trend Movie in day"
    case trendingMovieWeek = "Trend Movie in week"
    
    //    case tvPopular = "Popular TV"
    //    case tredingTv = "Trend TV in week"
    
    //    static let allValues = [trendingAll, tvPopular, trendingMovie, tredingTv]
}

class Networking {
    
    static var shared = Networking()
    
    let movieUrl = "https://api.themoviedb.org/3"
    
    private let key = "?api_key=3180eef08dadb9ca352d50241ce95409"
    
    func performRequest(category: Categories, completion: @escaping (CategoryMovie) -> Void)  {
        
        let fullUrl: String
        switch category {
        case .trendingAllDay: fullUrl = movieUrl + "/trending/all/day" + key
        case .trendingAllWeek: fullUrl = movieUrl + "/trending/all/week" + key
        case .trendingMovieDay: fullUrl = movieUrl + "/trending/movie/day" + key
        case .trendingMovieWeek: fullUrl = movieUrl + "/trending/movie/week" + key
            //        case .tvPopular: fullUrl = movieUrl + "/tv/popular" + key
            //        case .tredingTv: fullUrl = movieUrl + "/trending/tv/week" + key
        }
        
        guard let url = URL(string: fullUrl) else { return }
        print(url)
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, _, error in
            if error != nil {
                print("Error response, \(String(describing: error?.localizedDescription))")
                return
            }
            guard let safeData = data else { return }
            guard let movieCategory = self.parseJSON(safeData, category) else { return }
            completion(movieCategory)
        }
        
        task.resume()
    }
    
    func parseJSON(_ movieData: Data, _ category: Categories) -> CategoryMovie? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(MovieList.self, from: movieData)
            let movieList = decodeData.results
            var movies: [MovieCard] = []
            for movie in movieList {
                let newMovie = MovieCard(
                    name: movie.name ?? movie.title,
                    posterString: movie.posterPath,
                    backdropString: movie.backdropPath,
                    dateString: movie.releaseDate ?? movie.firstAirDate,
                    star: movie.voteAverage,
                    description: movie.overview
                )
                movies.append(newMovie)
            }
            let categoryMovie = CategoryMovie(name: category, movies: movies)
            return categoryMovie
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
