//
//  DataFetcherService.swift
//  Movie Dreams
//
//  Created by Konstantin on 01.06.2022.
//

import Foundation

enum Categories: String, CaseIterable {
    case trendingAllDay = "All Trend in day"
    case trendingAllWeek = "All Trend in week"
    case trendingMovieDay = "Trend Movie in day"
    case trendingMovieWeek = "Trend Movie in week"
    case continueMovie = "Continue watching movies"
}

class DataFetcherService {
    
    private let movieUrl = "https://api.themoviedb.org/3"
    
    private let key = "?api_key=3180eef08dadb9ca352d50241ce95409"
    
    var dataFetcher: DataFetcher!
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    //Fetch Data with categories
    func fetchData(category: Categories, completion: @escaping (MovieList?) -> Void) {
        let fullUrl: String
        
        switch category {
        case .trendingAllDay: fullUrl = movieUrl + "/trending/all/day" + key
        case .trendingAllWeek: fullUrl = movieUrl + "/trending/all/week" + key
        case .trendingMovieDay: fullUrl = movieUrl + "/trending/movie/day" + key
        case .trendingMovieWeek: fullUrl = movieUrl + "/trending/movie/week" + key
        case .continueMovie: return
        }
        dataFetcher.fetchGnericJSONData(urlString: fullUrl, response: completion)
    }
    //Fetch Data for the chosen movie
    func fetchData(ofType type: String, withId id: Int, completion: @escaping (DetailMovieData?) -> Void) {
        let fullUrl = "\(movieUrl)/\(type)/\(id)\(key)"
        dataFetcher.fetchGnericJSONData(urlString: fullUrl, response: completion)
    }
    //Fetch movie credits data
    func fetchCreditsData(ofType type: String, withId id: Int, completion: @escaping (DetailCreditsData?) -> Void) {
        let fullUrl = "\(movieUrl)/\(type)/\(id)/credits\(key)"
        dataFetcher.fetchGnericJSONData(urlString: fullUrl, response: completion)
    }
    
}
