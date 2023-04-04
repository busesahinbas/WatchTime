//
//  DetailViewController.swift
//  WatchTime
//
//  Created by Buse Şahinbaş on 30.03.2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var movieType: UILabelPadding!
    @IBOutlet weak var detailTableView: UITableView!
    
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 119
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
       
}
