//
//  UserEntity+Mapper.swift
//  GithubGists
//
//  Created by Vinicius Romani on 21/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation

extension User: MappableModelProtocol {
    
    init(mapping entity: UserEntity) throws {
        id = entity.id
        userName = entity.userName
        userGithubURL = entity.userGithubURL
        avatarURL = entity.avatarURL
    }
}
