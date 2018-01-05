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
    
    public func mapEntity<T: Decodable>(_ type: T.Type) -> Observable<T> {
        let mappedEntity = flatMap { response -> Observable<T> in
            guard let entity = try? JSONDecoder().decode(T.self, from: response.data) else {
                return Observable.error(JSONError.cannotMapToEntity)
            }
            return Observable.just(entity)
        }
        return mappedEntity
    }
}

extension ObservableType where E == GistEntity {
    func mapGists() -> Observable<Gist> {
        let mappedModel = flatMap { entity -> Observable<Gist> in
            do {
                let model = try Gist(mapping: entity)
                return Observable.just(model)
            } catch let error {
                return Observable.error(error)
            }
        }
        return mappedModel
    }
}


