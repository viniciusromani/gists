//
//  FileEntity+Mapper.swift
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

extension File: MappableModelProtocol {
    init<T>(mapping entity: T) throws where T : Decodable {
        guard let fileEntity = entity as? FileEntity, fileEntity.size > 0 else {
            throw JSONError.cannotMapToEntity
        }
        name = fileEntity.name
        size = fileEntity.size
        language = fileEntity.language
        url = fileEntity.url
    }
}
