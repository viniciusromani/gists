//
//  MappableEntityProtocol.swift
//  GithubGists
//
//  Created by Vinicius Romani on 22/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import RxSwift

/*
 * This is a custom protocol that defines how an entity is
 * parsed into a model. The only required method is init()
 * and it is where each model attribute is going to be
 * filled by its respective entity attribute
 */

protocol MappableModelProtocol {
    init<T: Decodable>(mapping entity: T) throws
    static func array<T: Decodable>(mapping entities: [T]) throws -> [Self]
}

extension MappableModelProtocol {
    static func array<T: Decodable>(mapping entities: [T]) throws -> [Self] {
        return try entities.map { return try self.init(mapping: $0) }
    }
}

