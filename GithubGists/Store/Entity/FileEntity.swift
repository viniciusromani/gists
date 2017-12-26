//
//  File.swift
//  GithubGists
//
//  Created by Vinicius Romani on 14/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import SwiftyJSON

/*
 * Model Business rule:
 * It will be considered invalid if either does
 * not have a name or its size is less than 0.
 * JSON example:
 * "ring.erl": {
 *     "size": 932,
 *     "raw_url": "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl",
 *     "type": "text/plain",
 *     "language": "Erlang",
 *     "truncated": false,
 *     "content": "contents of gist"
 *  }
 */

struct FileEntity {
    let name: String
    let size: Double
    let language: String?
    let url: String?
}

extension FileEntity: Decodable {
    enum CodingKeys: String, CodingKey {
        case name = "filename"
        case size = "size"
        case language = "language"
        case url = "raw_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        guard values.contains(.name), values.contains(.size) else { throw JSONError.keyNotFound }
        
        // Name treatment
        guard let parsedName = try? values.decode(String.self, forKey: .name) else { throw JSONError.typeMismatch }
        guard parsedName.count > 0 else { throw JSONError.cannotMapToEntity }
        name = parsedName
        
        // Other parameters
        size = try values.decodeIfPresent(Double.self, forKey: .size) ?? 0.0
        language = try? values.decode(String.self, forKey: .language)
        url = try? values.decode(String.self, forKey: .url)
    }
}




