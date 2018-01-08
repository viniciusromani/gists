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
 * parsed into a model. These are methods signatures that should
 * be followed for each model at the domain layer. It is recommended
 * to implement at least one of the init methods to initialize each
 * model's attributes with its respective entity attribute
 */

protocol MappableModelProtocol {
    init<T: Decodable>(mapping entity: T) throws
    init?<T: Decodable>(mapping entity: T?) throws
    static func array<T: Decodable>(mapping entities: [T]) throws -> [Self]
}

extension MappableModelProtocol {
    
    init<T: Decodable>(mapping entity: T) throws {
        try self.init(mapping: entity)
    }
    init?<T: Decodable>(mapping entity: T?) throws {
        guard let ent = entity else { return nil }
        try self.init(mapping: ent)
    }
    
    static func array<T: Decodable>(mapping entities: [T]) throws -> [Self] {
        return try entities.map { return try self.init(mapping: $0) }
    }
}

