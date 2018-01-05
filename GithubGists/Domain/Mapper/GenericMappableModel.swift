//
//  GenericMappableModel.swift
//  GithubGists
//
//  Created by Vinicius Romani on 03/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import Moya
import RxSwift

/*
 * This is a generic mapper to map entity (data layer) into models
 * (domain layer). If you would like to have your own mapper (recommended
 * for some specifics treatments your application may have) you
 * should use a different method name and signature. E.g:
 * extension ObservableType where E == CustomEntity {
 *     func mapUserPreferences() -> Observable<Custom> {
 *         /* use flatMap to map to your custom entity using a custom logic */
 *     }
 * }
 */

/*
 * Mapper for a single incoming model
 */
extension ObservableType where E: Decodable {
    
    func mapModel<T: MappableModelProtocol>() -> Observable<T> {
        let mappedModel = flatMap { entity -> Observable<T> in
            do {
                let model = try T.init(mapping: entity)
                return Observable.just(model)
            } catch let error {
                return Observable.error(error)
            }
        }
        return mappedModel
    }
}

/*
 * Mapper for an array of models
 */
extension ObservableType where E == Array<Decodable> {
    
    func mapModels<T: MappableModelProtocol>() -> Observable<[T]> {
        let mappedModels = flatMap { entities -> Observable<[T]> in
            do {
                
            }
        }
        return mappedModels
    }
}

