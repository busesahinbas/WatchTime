//
//  MovieViewModel.swift
//  WatchTime
//
//  Created by Buse Şahinbaş on 12.04.2023.
//

import Foundation

class MovieViewModel {
    
    var didFinishFetch: (() -> ())?
    
    private var service : Service?
    var movieResult : [Result]?
    var error : Error? {
        didSet {
            print("error")
        }
    }
    
    init(service: Service? = nil) {
        self.service = service
    }
    
    func getMoviePopular() {
        self.service?.getMovie(url: Endpoints.moviePopular.url, completion: { popularResult, error  in
            if let error = error {
                self.error = error
                return
            }
            self.movieResult = popularResult
            self.didFinishFetch?()
        })
    }
    
    func getMovieNowPlaying() {
        self.service?.getMovie(url: Endpoints.movieNowPlaying.url, completion: { nowPlayingResult, error  in
            if let error = error {
                self.error = error
                return
            }
            self.movieResult = nowPlayingResult
            self.didFinishFetch?()
        })
    }
    
    
}
