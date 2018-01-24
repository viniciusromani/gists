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

extension Gist: MappableModel {
    
    typealias Entity = GistEntity
    
    init(mapping entity: Entity) throws {
        guard entity.files.count > 0 else {
            throw JSONError.cannotMapToModel
        }
        
        id = entity.id
        description = entity.description
        apiURL = entity.apiURL
        htmlURL = entity.htmlURL
        files = try File.array(mapping: entity.files)
        owner = try User.init(mapping: entity.owner)
        isPublic = entity.isPublic
        createdAt = entity.createdAt
    }
}

extension ObservableType where E == GistEntity {
    func mapGist() -> Observable<Gist> {
        let mappedGist = flatMap { gistEntity -> Observable<Gist> in
            do {
                let gist = try Gist(mapping: gistEntity)
                return Observable.just(gist)
            } catch let error {
                return Observable.error(error)
            }
        }
        return mappedGist
    }
}

extension ObservableType where E == Array<GistEntity> {
    func mapGists() -> Observable<[Gist]> {
        return flatMap { entities -> Observable<[Gist]> in
            do {
                let models = try Gist.array(mapping: entities)
                return Observable.just(models)
            } catch let error {
                return Observable.error(error)
            }
        }
    }
}



