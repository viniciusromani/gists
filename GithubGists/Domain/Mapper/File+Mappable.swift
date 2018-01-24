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
 * Domain Business rule:
 * It will be considered invalid if either does
 * not have a valid name or its size is less than 0.
 */

extension File: MappableModel {
    
    typealias Entity = FileEntity
    
    init(mapping entity: Entity) throws {
        guard entity.name.count > 0, entity.size > 0 else {
            throw JSONError.cannotMapToModel
        }
        
        name = entity.name
        size = entity.size
        language = entity.language
        url = URL(string: entity.url ?? "")
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
