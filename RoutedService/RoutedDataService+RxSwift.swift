//
// Created by Manuel Vrhovac on 13/09/2019.
// Copyright © 2019 Manuel Vrhovac. All rights reserved.
// 

import Foundation


#if canImport(RxSwift)

import RxSwift

extension Reactive where Base: RoutedDataService {
    
    /// Use for requesting data (and not Codable types).
    func requestData(route: Base.Router) -> Observable<Base.Result<Data>> {
        return .create { observer -> Disposable in
            self.base.requestData(route: route, completion: observer.onNext)
            return Disposables.create()
        }
    }
}

#endif
