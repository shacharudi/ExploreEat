//
//  RequestDispatcher.swift
//  RestaurantsExplorer
//
//  Created by Shachar on 30/11/2018.
//  Copyright © 2018 Shachar. All rights reserved.
//

import Foundation
import Hydra
import Alamofire

protocol RequestDispatcherType {
    func dispatch<T>(_ route: RequestRoute, parser: RequestResponseParser<T>) -> Promise<T>
}

class RequestDispatcher: RequestDispatcherType {
    
    init() {}
    
    public func dispatch<T>(_ route: RequestRoute, parser: RequestResponseParser<T>) -> Promise<T> {
        return Promise<T> { resolve, reject, _ in
            let request = try self.getRouteRequest(route: route)
            Alamofire.request(request).responseJSON { response in
                parser.processResponse(response: response.result.value, statusCode: response.response?.statusCode)
                    .then { parsed in
                        resolve(parsed)
                    }.catch { error in
                        reject(error)
                }
            }
        }
    }
    
    private func getRouteRequest(route: RequestRoute) throws -> URLRequest {
        var request = try URLRequest(url: self.getRouteURL(route: route))
        
        request.allHTTPHeaderFields = route.headers
        request.httpMethod = route.method
        
        if let params = route.params {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params)
            } catch {
                Logger.error(message: "Unable to serialize RequestRoute params")
            }
        }
        return request
    }
    
    private func getRouteURL(route: RequestRoute) throws -> URL {
        guard let escapedRoute = route.path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL.init(string: escapedRoute) else {
            throw "error creating url path! \(route.path)"
        }
        return url
    }
}
