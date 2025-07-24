//
//  DateFormatter.swift
//  Lotto+Movie
//
//  Created by 금가경 on 7/24/25.
//

import Foundation

class MovieDateFormatter {
    static let dateFormatter = MovieDateFormatter()
    
    private init() {}
    
    private var defaultFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
    }()
    
    private var dashdateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
