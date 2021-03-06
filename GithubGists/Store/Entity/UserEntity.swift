//
//  User.swift
//  GithubGists
//
//  Created by Vinicius Romani on 14/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation

/*
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
    let id: Int
    let userName: String?
    let userGithubURL: String?
    let avatarURL: String?
}

