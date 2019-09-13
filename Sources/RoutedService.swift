//
// Created by Manuel Vrhovac on 11/09/2019.
// Copyright © 2019 Manuel Vrhovac. All rights reserved.
// 

import Foundation

protocol RoutedService {
    
    /// Create your own router enum, then conform it to URLRequestRouter.
    associatedtype Router: URLRequestRouter
    
    /// Used in '.custom(error: CustomError)' case of Error. See 'RoutedServiceError' for more.
    associatedtype CustomError: Swift.Error
    
    typealias Error = RoutedServiceError<CustomError>
    typealias Result<T> = Swift.Result<T, Error>
    typealias Completion<R> = (Result<R>) -> Void
}
