//
//  MovieViewModel.swift
//  WatchTime
//
//  Created by Buse Şahinbaş on 12.04.2023.
//

import Foundation
import Alamofire

struct MovieViewModel {
    
    
    init(){
        getMovie()
    }
    
    func getMovie() {
        AF
            .request("https://api.themoviedb.org/3/movie/now_playing?api_key=cddca74979cb6b2cd49d2a06b8ec0e2c&language=en-US&page=1",method: .get)
            .responseDecodable(of:Movie.self) { response in
                
                switch response.result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    
}
