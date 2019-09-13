//
// Created by Manuel Vrhovac on 11/09/2019.
// Copyright © 2019 Manuel Vrhovac. All rights reserved.
// 

import Foundation

protocol RoutedCodableService: RoutedDataService {
    
    /// Optional: Custom JSONDecoder used for different types.
    static func customDecoder<T>(for type: T.Type) -> JSONDecoder?
    
    /// Optional: Custom JSONEncoder used for different types.
    static func customEncoder<T>(for type: T.Type) -> JSONEncoder?
    
    /// Will call 'customDecoder(for:)' protocol method to obtain customDecoder
    func request<T: Codable>(_ type: T.Type, decoder: JSONDecoder?, route: Router, completion: Completion<T>?)
}

extension RoutedCodableService {
    
    /// Default: no custom decoder.
    static func customDecoder<T>(for type: T.Type) -> JSONDecoder? {
        return nil
    }
    
    /// Default: no custom encoder.
    static func customEncoder<T>(for type: T.Type) -> JSONEncoder? {
        return nil
    }

    func request<T: Codable>(_ type: T.Type, decoder: JSONDecoder? = nil, route: Router, completion: Completion<T>?) {
        requestData(route: route) { (result) in
            guard let completion = completion else { return }
            switch result {
            case .failure(let error):
                return completion(.failure(error))
            case .success(let data):
                do {
                    let decoder = decoder
                        ?? (T.self as? CustomDecodable.Type)?.customDecoder
                        ??  Self.customDecoder(for: T.self)
                        ?? .init()
                    let object = try T(jsonData: data, decoder: decoder)
                    completion(.success(object))
                } catch {
                    completion(.failure(.badJSON(error)))
                }
            }
        }
    }
}
