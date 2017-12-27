//
//  Gist.swift
//  GithubGists
//
//  Created by Vinicius Romani on 14/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation

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

struct GistEntity {
    let id: String
    let description: String?
    let apiURL: URL?
    let htmlURL: URL?
    var files: [FileEntity]
    let owner: UserEntity?
    let isPublic: Bool?
    let createdAt: Date?
}

extension GistEntity: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case description = "description"
        case apiURL = "url"
        case htmlURL = "html_url"
        case files = "files"
        case owner = "owner"
        case isPublic = "public"
        case createdAt = "created_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        guard values.contains(.id) else { throw JSONError.keyNotFound }
        
        // Id treatment
        guard let parsedId = try? values.decode(String.self, forKey: .id) else { throw JSONError.typeMismatch }
        guard parsedId.count > 0 else { throw JSONError.cannotMapToEntity }
        id = parsedId
        
        // Other parameters
        description = try? values.decode(String.self, forKey: .description)
        apiURL = try? values.decode(URL.self, forKey: .apiURL)
        htmlURL = try? values.decode(URL.self, forKey: .htmlURL)
        files = []
        let filesDictionary = try values.decode([String: FileEntity].self, forKey: .files)
        for (_, fileEntity) in filesDictionary.enumerated() {
            files.append(fileEntity.value)
        }
        owner = try? values.decode(UserEntity.self, forKey: .owner)
        isPublic = try? values.decode(Bool.self, forKey: .isPublic)
        createdAt = try? values.decode(Date.self, forKey: .createdAt)
    }
}
