//
//  Date + Extension.swift
//  Movie Dreams
//
//  Created by Konstantin on 25.05.2022.
//

import Foundation

extension Date {
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let date = formatter.string(from: self)
        return date
    }
}
