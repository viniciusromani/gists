//
//  MappableViewModel.swift
//  GithubGists
//
//  Created by Vinicius Romani on 24/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation

protocol MappableViewModel {
    associatedtype T: MappableModelProtocol
    
    init(mapping model: T)
    static func array(mapping models: [T]) -> [Self]
}

extension MappableViewModel {
    static func array(mapping models: [T]) -> [Self] {
        return models.map { return self.init(mapping: $0) }
    }
}
