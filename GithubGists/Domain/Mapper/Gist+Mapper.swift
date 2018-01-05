//
//  GistEntity+Mapper.swift
//  GithubGists
//
//  Created by Vinicius Romani on 22/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import RxSwift

/*
 * Domain business rule (described on Model folder)
 * is being applied while mapping an entity to a model.
 */

extension Gist: MappableModelProtocol {
    init<T>(mapping entity: T) throws where T: Decodable {
        guard let gistEntity = entity as? GistEntity, gistEntity.files.count > 0 else {
            throw JSONError.cannotMapToEntity
        }
        
        id = gistEntity.id
        description = gistEntity.description
        apiURL = gistEntity.apiURL
        htmlURL = gistEntity.htmlURL
        files = []
        owner = try User(mapping: gistEntity.owner)
        isPublic = gistEntity.isPublic
        createdAt = gistEntity.createdAt
    }
}
