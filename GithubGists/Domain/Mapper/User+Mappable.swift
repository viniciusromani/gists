//
//  UserEntity+Mapper.swift
//  GithubGists
//
//  Created by Vinicius Romani on 21/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import RxSwift

extension User: MappableModel {
    
    typealias Entity = UserEntity
    
    init?(mapping entity: Entity?) throws {
        guard let userEntity = entity else {
            return nil
        }
        
        id = userEntity.id
        userName = userEntity.userName
        userGithubURL = userEntity.userGithubURL
        avatarURL = userEntity.avatarURL
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

