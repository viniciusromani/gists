//
//  GistViewModel+Mappable.swift
//  GithubGists
//
//  Created by Vinicius Romani on 24/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation

extension GistViewModel: MappableViewModel {
    
    typealias T = Gist
    
    init(mapping model: Gist) {
        id = model.id
        name = model.files.first?.name ?? ""
        userImageURL = model.owner?.avatarURL
        userName = model.owner?.userName
    }
}
