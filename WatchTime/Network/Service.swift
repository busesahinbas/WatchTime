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
    
    // MARK: -Movie Request
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
    
    // MARK: -Series Request
    func getSeries(url: String, completion: @escaping ([SeriesResult]?, Error?) -> ()) {
        let req = SeriesRequest()
        
        makeRequest(url: url, req, resp: Series.self) { response, error in
            guard let response = response, error == nil else {
                completion(nil, error)
                return
            }
            completion(response.results, nil)
        }
        
    }
    
    
}
