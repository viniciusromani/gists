//
//  MappableEntityProtocol.swift
//  GithubGists
//
//  Created by Vinicius Romani on 22/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation

protocol MappableEntityProtocol {
    associatedtype T
    
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
        return nil
    }
    
    static func array(mapping entities: [T]) -> [Self] {
        return entities.map { return self.init(mapping: $0) }
    }
    static func array(mapping entities: [T]?) -> [Self]? {
        guard let unwrapped = entities else { return nil }
        return unwrapped.map { return self.init(mapping: $0) }
    }
}

