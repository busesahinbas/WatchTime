//
//  Util.swift
//  WatchTime
//
//  Created by Buse Şahinbaş on 9.05.2023.
//

import Foundation
import UIKit

func makeAlert(title:MessageTitle, description:String, view:UIViewController) {
    let alert = UIAlertController(title: title.rawValue, message: description, preferredStyle: UIAlertController.Style.alert)
    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
    alert.addAction(okButton)
    view.present(alert, animated: true, completion: nil)
}
