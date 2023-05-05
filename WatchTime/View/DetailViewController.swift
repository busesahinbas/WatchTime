//
//  DetailViewController.swift
//  WatchTime
//
//  Created by Buse Şahinbaş on 30.03.2023.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieType: UILabelPadding!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    
    @IBOutlet weak var detailTableView: UITableView!
    
    var result : Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUp()
        self.configure()
    }
    
    func setUp(){
        movieType.layer.cornerRadius = movieType.frame.height/2
        movieType.layer.borderWidth = 0.5
        movieType.clipsToBounds = true
        movieType.layer.borderColor = UIColor.lightGray.cgColor
        
        registerDetailTableView()
        detailTableView.dataSource = self
        detailTableView.delegate = self
    }
    
    func configure(){
        guard let result = result else { return }
        movieName.text = result.originalTitle
        movieLanguage.text = result.originalLanguage.uppercased()
        movieRate.text = result.voteText
        movieType.text = result.genre
        
        guard let dowloadUrl = URL(string: result.posterUrl) else { return }
        image.kf.setImage(with: ImageResource(downloadURL: dowloadUrl),
                          placeholder: UIImage(named: "loading.gif"))
        
        let blurProcessor = DownsamplingImageProcessor(size: movieImageView.bounds.size)
        |> BlurImageProcessor(blurRadius: 10)
        
        movieImageView.kf.setImage(
            with: dowloadUrl,
            placeholder: nil,
            options: [
                .processor(blurProcessor),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ]
        )
        
        detailTableView.reloadData()
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func registerDetailTableView(){
        detailTableView.register(UINib(nibName: "DetailViewCell", bundle: nil), forCellReuseIdentifier: "DetailViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailViewCell", for: indexPath) as? DetailViewCell else { return UITableViewCell() }
        
        cell.textView.text = result?.overview
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height/8
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
