//
//  UIViewController+Extensions.swift
//  MyAlbum
//
//  Created by Arnaldo on 8/23/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import UIKit

extension UIViewController {
    func showMessage(title: String = "Error", _ message: String? = "Ups, something went wrong".localized) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok".localized, style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
