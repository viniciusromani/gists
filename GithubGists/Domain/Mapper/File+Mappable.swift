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

extension File: MappableModel {
    
    typealias Entity = FileEntity
    
    init(mapping entity: Entity) throws {
        guard entity.size > 0 else {
            throw JSONError.cannotMapToModel
        }
        
        name = entity.name
        size = entity.size
        language = entity.language
        url = entity.url
    }
}

extension ObservableType where E == FileEntity {
    func mapFile() -> Observable<File> {
        let mappedFile = flatMap { fileEntity -> Observable<File> in
            do {
                let file = try File(mapping: fileEntity)
                return Observable.just(file)
            } catch let error {
                return Observable.error(error)
            }
        }
        return mappedFile
    }
}
