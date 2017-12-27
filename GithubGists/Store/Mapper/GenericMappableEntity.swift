//
//  GenericMappableEntity.swift
//  GithubGists
//
//  Created by Vinicius Romani on 27/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import Moya
import RxSwift

extension ObservableType where E == Response {
    
    func mapEntity<T: Decodable>() -> Observable<T> {
        let mappedEntity = flatMap { response -> Observable<T> in
            guard let entity = try? JSONDecoder().decode(T.self, from: response.data) else {
                return Observable.error(JSONError.cannotMapToEntity)
            }
            return Observable.just(entity)
        }
        return mappedEntity
    }
}
