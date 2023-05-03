//
//  FavoritesViewController.swift
//  WatchTime
//
//  Created by Buse Şahinbaş on 3.05.2023.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoritesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerTableView()
        favoritesTable.dataSource = self
        favoritesTable.delegate = self
        // Do any additional setup after loading the view.
    }
    

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func registerTableView(){
        favoritesTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
        else { return UITableViewCell() }
        
        //cell.configure(result: nowPlayingResult, indexPath: indexPath)
        cell.moiveLabel.text = "testt"
        
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
        //vc?.result = self.nowPlayingResult?[indexPath.row]
        
        navigationController?.pushViewController(vc!, animated: true)
    }
}
