//
//  CollectionViewCell.swift
//  WatchTime
//
//  Created by Buse Sahinbas on 28.03.2023.
//

import UIKit
import Kingfisher

class HorizontalCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(result : [Result]?, indexPath : IndexPath) {
        guard let result = result else { return }
        movieName.text = result[indexPath.row].originalTitle
        movieRate.text = result[indexPath.row].voteText
        
        let downloadUrl = URL(string: (result[indexPath.row].posterUrl))!
        movieImage.kf.setImage(with: ImageResource(downloadURL: downloadUrl),
                                    placeholder: UIImage(named: "loading.gif"),
                                    options: [.processor(RoundCornerImageProcessor(cornerRadius: 50))])
    }

}
