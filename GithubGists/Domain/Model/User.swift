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

struct User {
    let id: Int
    let userName: String?
    let userGithubURL: String?
    let avatarURL: String?
    
    init?(with json: JSON?) {
        guard let parseJSON = json else { return nil }
        guard let parseId = parseJSON["id"].int, parseId != 0 else { return nil }
        id = parseId
        userName = parseJSON["login"].string
        userGithubURL = parseJSON["html_url"].string
        avatarURL = parseJSON["avatar_url"].string
    }
}
