//
//  UserEntity+Mapper.swift
//  GithubGists
//
//  Created by Vinicius Romani on 21/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import RxSwift

/*
 * Domain Business rule:
 * It will be considered invalid if
 * the id is lower than 0.
 */

extension User: MappableModel {
    
    typealias Entity = UserEntity
    
    init?(mapping entity: UserEntity?) throws {
        guard let userEntity = entity else { return nil }
        guard userEntity.id > 0 else { throw JSONError.cannotMapToModel }
        
        id = "\(userEntity.id)"
        userName = userEntity.userName
        userGithubURL = URL(string: userEntity.userGithubURL ?? "")
        avatarURL = URL(string: userEntity.avatarURL ?? "")
    }
}

extension ObservableType where E == UserEntity {
    func mapUser() -> Observable<User> {
        let mappedUser = flatMap { userEntity -> Observable<User> in
            do {
                let user = try User(mapping: userEntity)
                return Observable.just(user)
            } catch let error {
                return Observable.error(error)
            }
        }
        return mappedUser
    }
}

