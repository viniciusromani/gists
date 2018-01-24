//
//  MappableModel.swift
//  GithubGists
//
//  Created by Vinicius Romani on 24/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
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

protocol MappableModel {
    associatedtype Entity: MappableEntity
    
    init(mapping entity: Entity) throws
    init?(mapping entity: Entity?) throws
    static func array(mapping entities: [Entity]) throws -> [Self]
    static func array(mapping entities: [Entity]?) throws -> [Self]?
}

extension MappableModel {
    
    init(mapping entity: Entity) throws {
        try self.init(mapping: entity)
    }
    init?(mapping entity: Entity?) throws {
        guard let ent = entity else { return nil }
        try self.init(mapping: ent)
    }
    
    static func array(mapping entities: [Entity]) throws -> [Self] {
        return try entities.map { return try self.init(mapping: $0) }
    }
    static func array(mapping entities: [Entity]?) throws -> [Self]? {
        guard let ent = entities else { return nil }
        return try ent.map { return try self.init(mapping: $0) }
    }
}
