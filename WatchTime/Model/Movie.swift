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
