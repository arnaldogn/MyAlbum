//
//  String+Extensions.swift
//  MyAlbum
//
//  Created by Arnaldo on 8/23/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
