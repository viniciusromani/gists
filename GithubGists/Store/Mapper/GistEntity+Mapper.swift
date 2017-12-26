//
//  GistEntity+Mapper.swift
//  GithubGists
//
//  Created by Vinicius Romani on 22/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation

extension Gist: MappableEntityProtocol {
    init(mapping entity: GistEntity) {
        id = entity.id
        description = entity.description
        apiURL = entity.apiURL
        htmlURL = entity.htmlURL
        files  = File.array(mapping: entity.files)
        owner = User(mapping: entity.owner)
        isPublic = entity.isPublic
    }
}
