//
//  Movie.swift
//  WatchTime
//
//  Created by Buse Şahinbaş on 10.04.2023.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movie = try? JSONDecoder().decode(MovieNowPlaying.self, from: jsonData)


// MARK: - Movie
struct Movie: Codable {
    
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, title: String
    let voteAverage: Double
    
    var voteText : String {
        return "\(voteAverage) /10 IMDB"
    }
    
    var posterUrl : String {
         return "https://image.tmdb.org/t/p/w500\(posterPath)"
    }

    var genre : String {
        switch genreIDS[0]{
        case 28:
            return "Action"
        case 12:
            return "Adventure"
        case 16:
            return "Animation"
        case 35:
            return "Comedy"
        case 80:
            return "Crime"
        case 99:
            return "Documentary"
        case 18:
            return "Drama"
        case 10751:
            return "Family"
        case 14:
            return "Fantasy"
        case 36:
            return "History"
        case 27:
            return "Horror"
        case 10402:
            return "Music"
        case 9648:
            return "Mystery"
        case 10749:
            return "Romance"
        case 878:
            return "Science Fiction"
        case 10770:
            return "TV Movie"
        case 53:
            return "Thriller"
        case 10752:
            return "War"
        case 37:
            return "Western"
        default:
            return "Unkonwn"
        }
    }
    
    
    enum CodingKeys: String, CodingKey {
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case title
        case voteAverage = "vote_average"
    }
    
}

struct MovieRequest: Codable {}


