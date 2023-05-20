//
//  DetailViewController.swift
//  WatchTime
//
//  Created by Buse Şahinbaş on 30.03.2023.
//

import UIKit
import Kingfisher
import Firebase

class DetailViewController: UIViewController {
    
    @IBOutlet weak var blurImageView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieType: UILabelPadding!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    
    var result : Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUp()
        self.configure()
        self.checkIsSaved()
    }
    
    func checkIsSaved(){
        
        guard let result = result else {
            return
        }
        if(documentArray.contains(String(result.id))){
            saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            reloadInputViews()
        }
        
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
        movieLanguage.text = result.language
        movieRate.text = result.voteText
        movieType.text = result.genre
        
        guard let dowloadUrl = URL(string: result.posterUrl) else { return }
        movieImageView.kf.setImage(with: ImageResource(downloadURL: dowloadUrl),
                                   placeholder: UIImage(named: "loading.gif"))
        
        let blurProcessor = DownsamplingImageProcessor(size: blurImageView.bounds.size)
        |> BlurImageProcessor(blurRadius: 10)
        
        blurImageView.kf.setImage(
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
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        //TODO: check is already saved
        
        let firestoreDatabase = Firestore.firestore()
        
        guard let result = self.result else { return }
        let firestorePost: [String : Any] = [Document.date.rawValue : FieldValue.serverTimestamp(), Document.user.rawValue : Auth.auth().currentUser!.email!, Document.imageUrl.rawValue : result.posterPath, Document.movieName.rawValue : result.originalTitle, Document.movieType.rawValue : result.genreIDS, Document.movieRate.rawValue: result.voteAverage, Document.movieLanguage.rawValue : result.originalLanguage, Document.movieDesc.rawValue : result.overview]
        
        let firestoreReference = firestoreDatabase.collection(Auth.auth().currentUser!.email!).document(String(result.id))
        
        firestoreReference.setData(firestorePost) { (error) in
            if let error = error {
                makeAlert(title: .error, description: error.localizedDescription, view: self)
                return
            }
            
            self.saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            self.reloadInputViews()
            
            self.tabBarController?.selectedIndex = 1
        }
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
