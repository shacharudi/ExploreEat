//
//  Images.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 01/12/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

enum DefaultImage {
    static let noCountryFlag = UIImage.from(color: Colors.primaryColor)
}

class Images {
    static func setImage(imageView: UIImageView, urlString: String, defaultImage: UIImage) {
        guard let url = URL(string: urlString) else {
            Logger.error(message: "Error parsing url: \(urlString)")
            return
        }        
        imageView.kf.setImage(with: url, placeholder: defaultImage)
    }
}
