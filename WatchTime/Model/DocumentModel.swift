//
//  DocumentModel.swift
//  WatchTime
//
//  Created by Buse Şahinbaş on 17.05.2023.
//

import Foundation

// MARK: - Firestore Document Model
enum Document: String {
    case user
    case date
    case documentID
    case movieDesc
    case movieLanguage
    case movieName
    case movieRate
    case movieType
    case imageUrl
    
    var rawValue: String {
        switch self {
        case .user:
            return "user"
        case .date:
            return "date"
        case .documentID:
            return "documentID"
        case .movieDesc:
            return "movieDesc"
        case .movieLanguage:
            return "movieLanguage"
        case .movieName:
            return "movieName"
        case .movieRate:
            return "movieRate"
        case .movieType:
            return "movieType"
        case .imageUrl:
            return "imageUrl"
        }
    }
}

