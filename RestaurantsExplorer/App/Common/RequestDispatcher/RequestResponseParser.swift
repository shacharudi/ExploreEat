//
//  RequestResponseParser.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 30/11/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import Hydra
import SwiftyJSON

typealias ParseResponseBlock<T> = ((_ response: JSON) -> T)

class RequestResponseParser<T> {
    
    var parseResponse: ParseResponseBlock<T>?

    static func create<T>(
            parseBlock: @escaping ((_ response: JSON) -> T)
        ) -> RequestResponseParser<T> {
        
        let parser = RequestResponseParser<T>()
        parser.parseResponse = parseBlock
        return parser
    }
    
    final func processResponse(response: Any?, statusCode: Int?) -> Promise<T> {
        return Promise<T> { resolve, reject, _ in
            if let isStatusCode = statusCode {
                switch isStatusCode {
                case 200:
                    if let isResponse = response, let parsedResponse = self.parseResponse?(JSON(isResponse)) {
                        resolve(parsedResponse)
                    } else {
                        Logger.error(message: "Response parser created without a parse response function!")
                    }
                case 400:
                    Logger.error(message: "\(response ?? "No error code")")
                default:
                    reject("unknown status code on http response!")
                }
            } else {
                reject("No status code in http response")
            }
        }
    }
}
