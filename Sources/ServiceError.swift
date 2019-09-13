//
// Created by Manuel Vrhovac on 07/09/2019.
// Copyright © 2019 Manuel Vrhovac. All rights reserved.
// 

import Foundation

/// Errors that can show up when using RoutedService. Generic with 1 type parameter: CustomError. It's used in the '.custom(error: CustomError)' case.
enum RoutedServiceError<CustomError: Error>: Error, LocalizedError {
    
    case badRequest
    case url(_ error: Error)
    case noData(response: URLResponse?)
    case badJSON(_ error: Error)
    case custom(_ error: CustomError)
    case empty
}
