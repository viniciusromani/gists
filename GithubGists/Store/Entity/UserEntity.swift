//
//  User.swift
//  GithubGists
//
//  Created by Vinicius Romani on 14/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import SwiftyJSON

/*
 * Model Business rule:
 * It will be considered invalid if it does not have an id.
 * ID will be retrieved from incoming json through the key "id"
 * JSON example:
 * "owner": {
 *     "login": "delaguardiap",
 *     "id": 14941828,
 *     "avatar_url": "https://avatars0.githubusercontent.com/u/14941828?v=4",
 *     "gravatar_id": "",
 *     "url": "https://api.github.com/users/delaguardiap",
 *     "html_url": "https://github.com/delaguardiap",
 *     "followers_url": "https://api.github.com/users/delaguardiap/followers",
 *     "following_url": "https://api.github.com/users/delaguardiap/following{/other_user}",
 *     "gists_url": "https://api.github.com/users/delaguardiap/gists{/gist_id}",
 *     "starred_url": "https://api.github.com/users/delaguardiap/starred{/owner}{/repo}",
 *     "subscriptions_url": "https://api.github.com/users/delaguardiap/subscriptions",
 *     "organizations_url": "https://api.github.com/users/delaguardiap/orgs",
 *     "repos_url": "https://api.github.com/users/delaguardiap/repos",
 *     "events_url": "https://api.github.com/users/delaguardiap/events{/privacy}",
 *     "received_events_url": "https://api.github.com/users/delaguardiap/received_events",
 *     "type": "User",
 *     "site_admin": false
 * }
 */

struct UserEntity {
    let id: String
    let userName: String?
    let userGithubURL: URL?
    let avatarURL: URL?
}

extension UserEntity: Decodable {
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




