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
    
    init(mapping entity: GistEntity) throws {
        guard entity.files.count > 0 else {
            throw JSONError.cannotMapToEntity
        }
        
        id = entity.id
        description = entity.description
        apiURL = entity.apiURL
        htmlURL = entity.htmlURL
        files = try File.array(mapping: entity.files)
        owner = nil
        
        isPublic = entity.isPublic
        createdAt = entity.createdAt
    }
}
