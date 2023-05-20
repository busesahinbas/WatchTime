//
//  Service.swift
//  WatchTime
//
//  Created by Buse Sahinbas on 17.04.2023.
//

import Foundation
import Alamofire
import UIKit

struct Service {
    
    // MARK: - Singleton
    static let shared = Service()
    
    // MARK: -BaseURL
    //static let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=cddca74979cb6b2cd49d2a06b8ec0e2c&language=en-US&page=1"
    
    // MARK: -Service
    func makeRequest<T: Decodable, P: Encodable>(url: String, _ req: P, resp: T.Type, _ completion: @escaping ((_ response: T?, _ error: Error?) -> Void)){
        AF
            .request(url, method: .get)
            .responseDecodable(of:resp) { response in
                switch response.result {
                case .success(let data):
                    completion(data, nil)
                case .failure(let error):
                    print(error)
                    completion(nil, error)
                }
            }
    }
    
    func getMovie(url: String, completion: @escaping ([Result]?, Error?) -> ()) {
        let req = MovieRequest()
        
        makeRequest(url: url, req, resp: Movie.self) { response, error in
            guard let response = response, error == nil else {
                completion(nil, error)
                return
            }
            completion(response.results, nil)
        }
        
    }
    
}
