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

extension ObservableType where E: Decodable {
    
    func mapModel<T: MappableModelProtocol>(_ type: E.Type) -> Observable<T> {
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
