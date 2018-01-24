//
//  UserEntity+Mappable.swift
//  GithubGists
//
//  Created by Vinicius Romani on 24/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation

extension UserEntity: MappableEntity {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userName = "login"
        case userGithubURL = "html_url"
        case avatarURL = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        guard values.contains(.id) else { throw JSONError.cannotMapToEntity }
        
        id = try values.decode(Int.self, forKey: .id)
        userName = try? values.decode(String.self, forKey: .userName)
        userGithubURL = try? values.decode(String.self, forKey: .userGithubURL)
        avatarURL = try? values.decode(String.self, forKey: .avatarURL)
    }
}
