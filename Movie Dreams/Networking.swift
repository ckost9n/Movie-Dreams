//
//  Networking.swift
//  Movie Dreams
//
//  Created by Konstantin on 27.05.2022.
//

import Foundation

enum Categories: String {
    case trendingAll = "/trending/all/week"
    case tvPopular = "/tv/popular"
    case trendingMovie = "/trending/movie/week"
    case tredingTv = "/trending/tv/week"
}

struct Networking {
    
    static var shared = Networking()
    
    let movieUrl = "https://api.themoviedb.org/3/"
    
    private let key = "?api_key=3180eef08dadb9ca352d50241ce95409"
    
    func fetchUrl(category: Categories) {
        let fullUrl = movieUrl + category.rawValue + key
        performRequest(with: fullUrl)
    }
    
    
    
    func performRequest(with urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        print(url)
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
//                delegate?.didFailWithError(error: error!)
                print("Error response, \(String(describing: error))")
                return
            }
            guard let safeData = data else { return }
            parseJSON(safeData)
        }
        
        task.resume()
    }
    
    func parseJSON(_ movieData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(MovieList.self, from: movieData)
            print(decodeData.results[0].title ?? "")
            print("---------")
            print(decodeData.results[0].backdropPath)
        } catch {
            print("Error decode \(error)")
        }
    }
}
