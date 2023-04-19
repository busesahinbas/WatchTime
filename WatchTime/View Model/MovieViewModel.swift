//
//  MovieViewModel.swift
//  WatchTime
//
//  Created by Buse Şahinbaş on 12.04.2023.
//

import Foundation
import Alamofire

class MovieViewModel {
    
    var didFinishFetch: (() -> ())?
    
    private var service : Service?
    var popularResult : [Result]?
    var error : Error? {
        didSet {
            print("error")
        }
    }
    
    init(service: Service? = nil) {
        self.service = service
    }
    
    func getMoviePopular(url: String) {
        self.service?.getMovie(url: url, completion: { popularResult, error  in
            if let error = error {
                self.error = error
                return
            }
            self.popularResult = popularResult
            self.didFinishFetch?()
            
            
        })
        
    }
    
    
}
