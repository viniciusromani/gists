//
//  Gist.swift
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
 * {
 *     "url": "https://api.github.com/gists/9ae003ae416b7cbda08a1e0b98db331c",
 *     "forks_url": "https://api.github.com/gists/9ae003ae416b7cbda08a1e0b98db331c/forks",
 *     "commits_url": "https://api.github.com/gists/9ae003ae416b7cbda08a1e0b98db331c/commits",
 *     "id": "9ae003ae416b7cbda08a1e0b98db331c",
 *     "git_pull_url": "https://gist.github.com/9ae003ae416b7cbda08a1e0b98db331c.git",
 *     "git_push_url": "https://gist.github.com/9ae003ae416b7cbda08a1e0b98db331c.git",
 *     "html_url": "https://gist.github.com/9ae003ae416b7cbda08a1e0b98db331c",
 *     "files": {
 *         Described in File Model
 *     },
 *     "public": true,
 *     "created_at": "2017-12-18T16:20:32Z",
 *     "updated_at": "2017-12-18T16:20:32Z",
 *     "description": "Array basic drills links",
 *     "comments": 0,
 *     "user": null,
 *     "comments_url": "https://api.github.com/gists/9ae003ae416b7cbda08a1e0b98db331c/comments",
 *     "owner": {
 *         Described in User Model
 *     },
 *     "truncated": false
 * }
 */

struct Gist {
    let id: String
    let description: String?
    let apiURL: String?
    let htmlURL: String?
    var files: [File?]
    let owner: User?
    let isPublic: Bool?
    
    init?(with json: JSON?) {
        guard let parseJSON = json else { return nil }
        guard let parseId = parseJSON["id"].string, parseId.count > 0 else { return nil }
        id = parseId
        description = parseJSON["description"].string
        apiURL = parseJSON["url"].string
        htmlURL = parseJSON["html_url"].string
        files = []
        for key in parseJSON["files"].dictionaryValue.keys {
            let file = File(with: parseJSON["files"][key])
            files.append(file)
        }
        owner = User(with: parseJSON["owner"])
        isPublic = parseJSON["public"].bool
    }
}



