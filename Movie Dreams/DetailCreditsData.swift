//
//  DetailCreditsData.swift
//  Movie Dreams
//
//  Created by Илья Шаповалов on 03.06.2022.
//

import Foundation

struct DetailCreditsData: Codable {
    let credits: [Cast]
    
    enum CodingKeys: String, CodingKey {
        case credits = "cast"
    }
}

struct Cast: Codable {
    let name, originalName: String?
    let character: String?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case character = "character"
        case originalName = "original_name"
        case profilePath = "profile_path"
    }
}


