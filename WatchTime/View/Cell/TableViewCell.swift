//
//  TableViewCell2.swift
//  WatchTime
//
//  Created by Buse Sahinbas on 27.03.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var moiveLabel: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var movieType: UILabel!
    
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
        
            // Configure the view for the selected state
    }
    
}
