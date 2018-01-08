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
 *     func mapCustom() -> Observable<Custom> {
 *         /* use flatMap to map to your custom entity using a custom logic */
 *     }
 * }
 * PS. You should implement your own mapper for arrays. There is an example
 * at the mapGists() method (located at Gist+Mapper.swift file)
 */

/*
 * Mapper for an incoming model
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
