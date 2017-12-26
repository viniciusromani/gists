//
//  GistEntity+Mapper.swift
//  GithubGists
//
//  Created by Vinicius Romani on 22/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation

extension Gist: MappableEntityProtocol {
    typealias T = GistEntity
    
    init(mapping entity: GistEntity) {
        id = entity.id
        description = entity.description
        apiURL = entity.apiURL
        htmlURL = entity.htmlURL
//        files  = File.array(mapping: entity.files)
        files = []
        owner = User(mapping: entity.owner)
        isPublic = entity.isPublic
        createdAt = entity.createdAt
    }
}
