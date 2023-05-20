//
//  ServiceHelper.swift
//  WatchTime
//
//  Created by Buse Şahinbaş on 9.04.2023.
//

import Foundation

let baseUrl = "https://api.themoviedb.org/3/"
let apiKey = "?api_key=cddca74979cb6b2cd49d2a06b8ec0e2c&language=en-US&page=1"

enum Endpoints {
    case moviePopular
    case movieNowPlaying
    
    var url: String {
        switch self {
        case .moviePopular:
            return baseUrl + "movie/popular" + apiKey
        case .movieNowPlaying:
            return baseUrl + "movie/now_playing" + apiKey
        }
    }
}
