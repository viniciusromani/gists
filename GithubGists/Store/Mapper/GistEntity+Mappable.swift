//
//  GistEntity+Mappable.swift
//  GithubGists
//
//  Created by Vinicius Romani on 24/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation

extension GistEntity: MappableEntity {
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
