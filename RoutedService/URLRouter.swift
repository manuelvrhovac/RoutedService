//
// Created by Manuel Vrhovac on 07/09/2019.
// Copyright © 2019 Manuel Vrhovac. All rights reserved.
// 

import Foundation

/// Has the ability to build a URL using scheme, host, path and query parametery
protocol URLRouter {
    
    /// Scheme like 'http'
    var scheme: String { get }
    
    /// Host like 'api.google.com'
    var host: String { get }
    
    /// Path like '/v1/all_topics'
    var path: String { get }
    
    /// Query parameters. Adds '?' on end of path, '&' between parameters and '=' between key/value. Value is converted into string.
    ///
    /// Example: `["sort": "name", "room": 1]` -->  `?sort=name&room=1&...`
    var parameters: [String: Any]? { get }
}

extension URLRouter {
    
    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = parameters?.map {
            URLQueryItem(name: $0.key, value: String(describing: $0.value))
        }
        return urlComponents
    }
    
    var url: URL? {
        return urlComponents.url
    }
}
