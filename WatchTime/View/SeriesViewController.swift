//
//  SeriesViewController.swift
//  WatchTime
//
//  Created by Buse Şahinbaş on 20.05.2023.
//

import UIKit
import Alamofire
import Kingfisher
import Firebase

class SeriesViewController: UIViewController {
    
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    @IBOutlet weak var seriesTableView: UITableView!
    
    var popularViewModel = SeriesViewModel(service: Service())
    var nowPlayingViewModel = SeriesViewModel(service: Service())
    var popularResult : [SeriesResult]?
    var nowPlayingResult : [SeriesResult]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetch()
        configure()
    }
    
    func fetch() {
        popularViewModel.getSeriesPopular()
        popularViewModel.didFinishFetch = {
            self.popularResult = self.popularViewModel.seriesResult
            self.seriesCollectionView.reloadData()
        }
        
        nowPlayingViewModel.getSeriesNowPlaying()
        nowPlayingViewModel.didFinishFetch = {
            self.nowPlayingResult = self.nowPlayingViewModel.seriesResult
            self.seriesTableView.reloadData()
        }
    }
    
    func configure() {
        registerCollectionView()
        registerTableView()
        seriesCollectionView.dataSource = self
        seriesCollectionView.delegate = self
        seriesTableView.dataSource = self
        seriesTableView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        seriesCollectionView.setCollectionViewLayout(layout, animated: true)
        
    }
}


extension SeriesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func registerCollectionView(){
        seriesCollectionView.register(UINib(nibName: "HorizontalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HorizontalCollectionViewCell")
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
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController,
              let selectedResult = self.popularResult?[indexPath.row] else {
            return
        }
        let newResult = castMyObject(seriesResult: selectedResult)
        vc.result = newResult
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SeriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func registerTableView(){
        seriesTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
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
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController,
              let selectedResult = self.nowPlayingResult?[indexPath.row] else {
            return
        }
        let newResult = castMyObject(seriesResult: selectedResult)
        vc.result = newResult
        navigationController?.pushViewController(vc, animated: true)
    }
}

