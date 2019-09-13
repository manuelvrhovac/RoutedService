//
// Created by Manuel Vrhovac on 13/09/2019.
// Copyright © 2019 Manuel Vrhovac. All rights reserved.
// 

import Foundation

#if canImport(RxSwift)

import RxSwift

extension Reactive where Base: RoutedCodableService {
        
    /// Use for types that conform to Codable completely.
    func request<T: Codable>(_ type: T.Type,
                             decoder: JSONDecoder? = nil,
                             route: Base.Router) -> Observable<Base.Result<T>> {
        return .create { observer -> Disposable in
            self.base.request(type, decoder: decoder, route: route) { result in
                observer.onNext(result)
            }
            return Disposables.create()
        }
    }
    
}

#endif
