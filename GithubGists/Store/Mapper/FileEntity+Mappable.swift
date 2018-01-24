//
//  FileEntity+Mappable.swift
//  GithubGists
//
//  Created by Vinicius Romani on 24/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation

extension FileEntity: MappableEntity {
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
        url = try? values.decode(URL.self, forKey: .url)
    }
}
