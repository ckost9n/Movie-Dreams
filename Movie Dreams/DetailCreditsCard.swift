//
//  DetailCreditsCard.swift
//  Movie Dreams
//
//  Created by Илья Шаповалов on 04.06.2022.
//

import Foundation

struct DetailCreditsCard {
    let cast: [CastList]
}

struct CastList {
    let name: String?
    let character: String?
    let profilePath: String?
    
    var profileURL: String? {
        guard profilePath != nil else { return nil }
        return "https://image.tmdb.org/t/p/w500" + (self.profilePath ?? "")
    }
    
    //MARK: - init()
    init(name: String?, character: String?, profilePath: String?) {
        self.name = name
        self.character = character
        self.profilePath = profilePath
    }
}
