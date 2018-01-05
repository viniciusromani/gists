//
//  MappableEntityProtocol.swift
//  GithubGists
//
//  Created by Vinicius Romani on 22/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import RxSwift

protocol MappableModelProtocol {
    init<T: Decodable>(mapping entity: T) throws
    
//    static func array(mapping entities: [T]) throws -> [Self]
//    static func array(mapping entities: [T]?) throws -> [Self]?
}

extension MappableModelProtocol {
//    static func array(mapping entities: [T]) throws -> [Self] {
//        return try entities.map { return try self.init(mapping: $0) }
//    }
//    static func array(mapping entities: [T]?) throws -> [Self]? {
//        guard let unwrapped = entities else { throw JSONError.cannotMapToEntity }
//        return try unwrapped.map { return try self.init(mapping: $0) }
//    }
}

