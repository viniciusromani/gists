//
//  MappableViewModel.swift
//  GithubGists
//
//  Created by Vinicius Romani on 24/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation

protocol MappableViewModel {
    associatedtype Model: MappableModel
    
    init(mapping model: Model)
    static func array(mapping models: [Model]) -> [Self]
}

extension MappableViewModel {
    static func array(mapping models: [Model]) -> [Self] {
        return models.map { return self.init(mapping: $0) }
    }
}
