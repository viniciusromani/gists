//
//  UserEntity+Mapper.swift
//  GithubGists
//
//  Created by Vinicius Romani on 21/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation

extension User: MappableModelProtocol {
    
    typealias T = UserEntity

    init?(mapping entity: UserEntity?) {
        guard let unwrapped = entity else { return nil }
        id = unwrapped.id
        userName = unwrapped.userName
        userGithubURL = unwrapped.userGithubURL
        avatarURL = unwrapped.avatarURL
    }
}

