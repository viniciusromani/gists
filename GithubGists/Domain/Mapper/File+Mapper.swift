//
//  FileEntity+Mapper.swift
//  GithubGists
//
//  Created by Vinicius Romani on 22/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation

/*
 * Domain business rule (described on Model folder)
 * is being applied while mapping an entity to a model.
 */

extension File: MappableModelProtocol {
    
    init(mapping entity: FileEntity) throws {
        guard entity.size > 0 else { throw JSONError.cannotMapToEntity }
        name = entity.name
        size = entity.size
        language = entity.language
        url = entity.url
    }
}
