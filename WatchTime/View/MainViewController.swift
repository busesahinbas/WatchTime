//
//  MainViewController.swift
//  WatchTime
//
//  Created by Buse Şahinbaş on 24.03.2023.
//

import UIKit
import Alamofire
import Kingfisher
import Firebase

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var popularViewModel = MovieViewModel(service: Service())
    var nowPlayingViewModel = MovieViewModel(service: Service())
    var popularResult : [Result]?
    var nowPlayingResult : [Result]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        popularViewModel.getMoviePopular()
        popularViewModel.didFinishFetch = {
            self.popularResult = self.popularViewModel.movieResult
            self.collectionView.reloadData()
        }
        
        nowPlayingViewModel.getMovieNowPlaying()
        nowPlayingViewModel.didFinishFetch = {
            self.nowPlayingResult = self.nowPlayingViewModel.movieResult
            self.tableView.reloadData()
        }
        
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
    
    @IBAction func signOutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            
            if let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() {
                UIApplication.shared.windows.first?.rootViewController = mainViewController
            }
            
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
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
        return CGSize(width:widthPerItem, height:250)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCollectionViewCell", for: indexPath) as? HorizontalCollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.configure(result: popularResult, indexPath: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.result = self.popularResult?[indexPath.row]
        navigationController?.pushViewController(vc!, animated: true)
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func registerTableView(){
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nowPlayingResult?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
        else { return UITableViewCell() }
        
        cell.configure(result: nowPlayingResult, indexPath: indexPath)
        
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
        vc?.result = self.nowPlayingResult?[indexPath.row]
        navigationController?.pushViewController(vc!, animated: true)
    }
}

