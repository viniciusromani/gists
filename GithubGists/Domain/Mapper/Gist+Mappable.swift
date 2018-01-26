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
 * Model Business rule:
 * It will be considered invalid if it
 * does not have a valid id.
 * It will be considered invalid if it
 * does not have any files related.
 */

extension Gist: MappableModel {
    
    typealias Entity = GistEntity
    
    init(mapping entity: Entity) throws {
        guard entity.id.trimmingCharacters(in: .whitespaces).count > 0, entity.files.count > 0 else {
            throw JSONError.cannotMapToModel
        }
        
        id = entity.id
        description = entity.description
        apiURL = URL(string: entity.apiURL?.trimmingCharacters(in: .whitespaces))
        htmlURL = URL(string: entity.htmlURL?.trimmingCharacters(in: .whitespaces))
        files = try File.array(mapping: entity.files)
        owner = try User(mapping: entity.owner)
        isPublic = Bool(truncating: entity.isPublic as NSNumber)
        let date = Date(usingIsoFormatterFor: entity.createdAt)
        createdAt = date
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



