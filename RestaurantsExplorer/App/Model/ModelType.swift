//
//  ModelType.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 01/12/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class ModelType: Object {
    public convenience init(json: JSON) {
        self.init()
    }
}
