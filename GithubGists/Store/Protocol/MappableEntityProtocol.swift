//
//  MappableEntityProtocol.swift
//  GithubGists
//
//  Created by Vinicius Romani on 22/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation

protocol MappableEntityProtocol {
    associatedtype T = Self
    
    init(mapping entity: T)
    init?(mapping entity: T?)
    
    static func array(mapping entities: [T]) -> [Self]
    static func array(mapping entities: [T]?) -> [Self]?
}

extension MappableEntityProtocol {
    
    init(mapping entity: T) {
        self.init(mapping: entity)
    }
    init?(mapping entity: T?) {
        self.init(mapping: entity)
    }
    
    static func array(mapping entities: [T]) -> [Self] {
        return entities.map { return Self(mapping: $0) }
    }
    static func array(mapping entities: [T]?) -> [Self]? {
        return nil
    }
}
