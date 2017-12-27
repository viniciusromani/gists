//
//  FileEntity+Mapper.swift
//  GithubGists
//
//  Created by Vinicius Romani on 22/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation

extension File: MappableEntityProtocol {
    
    typealias T = FileEntity
    
    init(mapping entity: FileEntity) {
        name = entity.name
        size = entity.size
        language = entity.language
        url = entity.url
    }
}
