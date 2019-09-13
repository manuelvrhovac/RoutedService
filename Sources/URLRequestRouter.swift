//
// Created by Manuel Vrhovac on 07/09/2019.
// Copyright © 2019 Manuel Vrhovac. All rights reserved.
// 

import Foundation
import Alamofire

/// Has the ability to build a URLRequest using http method, headers, body and url.
protocol URLRequestRouter: URLRouter {
    
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var body: Data? { get }
    var timeoutInterval: TimeInterval { get }
}

extension URLRequestRouter {
    
    /// Optional: Default: 60s
    var timeoutInterval: TimeInterval {
        return 60
    }
}


extension URLRequestRouter {
    
    var urlRequest: URLRequest? {
        guard let url = url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body
        urlRequest.timeoutInterval = timeoutInterval
        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        return urlRequest
    }
}


enum HTTPMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
