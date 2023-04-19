//
//  DetailViewController.swift
//  WatchTime
//
//  Created by Buse Şahinbaş on 30.03.2023.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieType: UILabelPadding!
    
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    
    @IBOutlet weak var detailTableView: UITableView!
    
    var viewModel = MovieViewModel()
    var index = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieType.layer.cornerRadius = movieType.frame.height/2
        movieType.layer.borderWidth = 0.5
        movieType.clipsToBounds = true
        movieType.layer.borderColor = UIColor.lightGray.cgColor
        // Do any additional setup after loading the view.
        
        registerDetailTableView()
        
        detailTableView.dataSource = self
        detailTableView.delegate = self
        
     
        movieName.text = viewModel.popularResult?[index].originalTitle
        movieLanguage.text = viewModel.popularResult?[index].originalLanguage.uppercased()
        movieRate.text = (viewModel.popularResult?[index].voteAverage.description ?? "0") + "/10 IMDb"
        movieType.text = viewModel.popularResult?[index].genreIDS[0].description
        
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
   
        //cell.label.text = viewModel.popularResult?[index].overview
        cell.textView.text = viewModel.popularResult?[index].overview
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height/4
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
       
}
