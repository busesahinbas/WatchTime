//
//  SeriesViewModel.swift
//  WatchTime
//
//  Created by Buse Şahinbaş on 20.05.2023.
//

import Foundation

class SeriesViewModel {
    
    var didFinishFetch: (() -> ())?
    
    private var service : Service?
    var seriesResult : [SeriesResult]?
    var error : Error? {
        didSet {
            print("error")
        }
    }
    
    init(service: Service? = nil) {
        self.service = service
    }
    
    func getSeriesPopular() {
        self.service?.getSeries(url: Endpoints.seriesPopular.url, completion: { popularResult, error  in
            if let error = error {
                self.error = error
                return
            }
            self.seriesResult = popularResult
            self.didFinishFetch?()
        })
    }
    
    func getSeriesNowPlaying() {
        self.service?.getSeries(url: Endpoints.seriesNowPlaying.url, completion: { nowPlayingResult, error  in
            if let error = error {
                self.error = error
                return
            }
            self.seriesResult = nowPlayingResult
            self.didFinishFetch?()
        })
    }
    
}
