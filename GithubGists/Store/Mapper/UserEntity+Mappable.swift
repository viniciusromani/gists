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
        guard values.contains(.id) else { throw JSONError.keyNotFound }
        
        // Id treatment
        guard let parsedId = try? values.decode(Int.self, forKey: .id) else { throw JSONError.typeMismatch }
        guard parsedId > 0 else { throw JSONError.cannotMapToEntity }
        id = "\(parsedId)"
        
        // Other parameters
        userName = try? values.decode(String.self, forKey: .userName)
        userGithubURL = try? values.decode(URL.self, forKey: .userGithubURL)
        avatarURL = try? values.decode(URL.self, forKey: .avatarURL)
    }
}
