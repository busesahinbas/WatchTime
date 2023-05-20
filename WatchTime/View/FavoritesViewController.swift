//
//  FavoritesViewController.swift
//  WatchTime
//
//  Created by Buse Şahinbaş on 3.05.2023.
//

import UIKit
import Firebase
import Kingfisher

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var favoritesTable: UITableView!
    
    var favResult = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        getDataFromFirestore()
    }
    
    func configure() {
        registerTableView()
        favoritesTable.dataSource = self
        favoritesTable.delegate = self
    }
    
    func getDataFromFirestore() {
        
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection("\(Auth.auth().currentUser!.email!)").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if snapshot?.isEmpty != true && snapshot != nil {
                
                self.favResult.removeAll(keepingCapacity: false)
                documentArray.removeAll(keepingCapacity: false)
                
                for document in snapshot!.documents {
                    
                    let documentID = document.documentID
                    documentArray.append(documentID)
                    UserDefaults.standard.set(documentArray, forKey: "documentArray")
                    
                    let documentResult = Result(
                        genreIDS: document.get(Document.movieType.rawValue) as! [Int],
                        id: Int(documentID)!,
                        originalLanguage: document.get(Document.movieLanguage.rawValue) as! String,
                        originalTitle: document.get(Document.movieName.rawValue) as! String,
                        overview: document.get(Document.movieDesc.rawValue) as! String,
                        popularity: 0.0,
                        posterPath: document.get(Document.imageUrl.rawValue) as! String ,
                        title: "",
                        voteAverage: document.get(Document.movieRate.rawValue) as! Double)
                    self.favResult.append(documentResult)
                }
                self.favoritesTable.reloadData()
            }
        }
    }
    
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func registerTableView(){
        favoritesTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  favResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
        else { return UITableViewCell() }
        
        cell.configure(result: favResult, indexPath: indexPath)
        
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
        vc?.result = self.favResult[indexPath.row]
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let firestoreDatabase = Firestore.firestore()
            let collectionRef = firestoreDatabase.collection(Auth.auth().currentUser!.email!)
            let documentRef = collectionRef.document(documentArray[indexPath.row])
            self.favResult.remove(at: indexPath.row)
            documentArray.remove(at: indexPath.row)
            
            documentRef.delete { error in
                if let error = error {
                    // Handle the error
                    print("Error deleting document: \(error.localizedDescription)")
                } else {
                    // Document successfully deleted
                    print("Document deleted successfully")
                    
                    // Update the data source by removing the deleted item
                  
                    UserDefaults.standard.set(documentArray, forKey: "documentArray")
                    
                    self.favoritesTable.reloadData()
                    
                }
            }
           
        }
    }
    
}
