//
//  MainViewController.swift
//  WatchTime
//
//  Created by Buse Şahinbaş on 24.03.2023.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieViewModel: MovieViewModel!
    var popularMovieResult = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getMovie()
        
        registerCollectionView()
        registerTableView()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        tableView.dataSource = self
        tableView.delegate = self
        
     
    }
    
    func getMovie() {
        AF
            .request("https://api.themoviedb.org/3/movie/now_playing?api_key=cddca74979cb6b2cd49d2a06b8ec0e2c&language=en-US&page=1", method: .get)
            .responseDecodable(of:Movie.self) { response in
                
                switch response.result {
                case .success(let data):
                    print(data)
                    do {
                        let instance = try JSONDecoder().decode(Movie.self, from: response.data!)
                        self.popularMovieResult = instance.results
                        self.collectionView.reloadData()
                        
                    } catch let error {
                      print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func registerCollectionView(){
        collectionView.register(UINib(nibName: "HorizontalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HorizontalCollectionViewCell")
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let gridLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2.5 - gridLayout.minimumInteritemSpacing
        return CGSize(width:widthPerItem, height:300)
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMovieResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCollectionViewCell", for: indexPath) as? HorizontalCollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.movieName.text = popularMovieResult[indexPath.row].originalTitle
        cell.movieRate.text = String(popularMovieResult[indexPath.row].voteAverage) + "/10 IMDb"
        
        return cell
    }
    

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func registerTableView(){
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 119
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        //vc?.image = UIImage(named: names[indexPath.row] )!
        //vc?.name = names[indexPath.row]
        navigationController?.pushViewController(vc!, animated: true)
    }
}


