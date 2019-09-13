//
// Created by Manuel Vrhovac on 11/09/2019.
// Copyright © 2019 Manuel Vrhovac. All rights reserved.
// 

import Foundation

protocol RoutedDataService: RoutedService {
    
    /// Use for requesting Data using URLSession.
    func requestData(route: Router, completion: Completion<Data>?)
    
    /// Implement this method for different routes to 'hijack' the completion, returning true (don't forget to execute completion). If route should not be mocked, simply return false.
    func requestMockData(for route: Router, completion: Completion<Data>?) -> Bool
}

extension RoutedDataService {
    
    /// If not implemented, never mock any data.
    func requestMockData(for route: Router, completion: Completion<Data>?) -> Bool {
        return false
    }
        
    func requestData(route: Router, completion: Completion<Data>?) {
        guard !requestMockData(for: route, completion: completion) else { return }
        guard let request = route.urlRequest else {
            completion?(.failure(.badRequest))
            return
        }
        urlSessionDataTask(request: request, completion: completion)
    }
    
    /// CONVENIENCE: Use for requesting Data
    func urlSessionDataTask(request: URLRequest, completion: Completion<Data>?) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let completion = completion else {
                    return }
                if let error = error {
                    return completion(.failure(.url(error)))
                }
                guard let data = data else {
                    return completion(.failure(.noData(response: response)))
                }
                return completion(.success(data))
            }
        }.resume()
    }
}

