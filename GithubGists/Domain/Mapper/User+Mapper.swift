//
//  UserEntity+Mapper.swift
//  GithubGists
//
//  Created by Vinicius Romani on 21/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import RxSwift

extension User: MappableModelProtocol {
    init?<T>(mapping entity: T?) throws {
        guard let userEntity = entity as? UserEntity else {
            return nil
        }
        
        id = userEntity.id
        userName = userEntity.userName
        userGithubURL = userEntity.userGithubURL
        avatarURL = userEntity.avatarURL
    }
}
