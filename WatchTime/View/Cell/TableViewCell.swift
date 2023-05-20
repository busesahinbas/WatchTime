//
//  TableViewCell2.swift
//  WatchTime
//
//  Created by Buse Sahinbas on 27.03.2023.
//

import UIKit
import Kingfisher

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var moiveLabel: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var movieType: UILabelPadding!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        movieType.layer.cornerRadius = movieType.frame.height/2
        movieType.layer.borderWidth = 0.5
        movieType.clipsToBounds = true
        movieType.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    func configure(result : [Result]?, indexPath : IndexPath) {
        guard let result = result else { return }
        moiveLabel.text = result[indexPath.row].originalTitle
        movieRate.text = result[indexPath.row].voteText
        movieLanguage.text = result[indexPath.row].language
        
        let downloadUrl = URL(string: (result[indexPath.row].posterUrl))!
        movieImage.kf.setImage(with: ImageResource(downloadURL: downloadUrl),
                               placeholder: UIImage(named: "loading.gif"),
                               options: [.processor(RoundCornerImageProcessor(cornerRadius: 50))])
    }
    
    func configure(result : [SeriesResult]?, indexPath : IndexPath) {
        guard let result = result else { return }
        moiveLabel.text = result[indexPath.row].name
        movieRate.text = result[indexPath.row].voteText
        movieType.text = result[indexPath.row].genre
        movieLanguage.text = result[indexPath.row].language
        
        let downloadUrl = URL(string: (result[indexPath.row].posterUrl))!
        movieImage.kf.setImage(with: ImageResource(downloadURL: downloadUrl),
                               placeholder: UIImage(named: "loading.gif"),
                               options: [.processor(RoundCornerImageProcessor(cornerRadius: 50))])
    }
}
