//
//  Gist+GistViewModelMapper.swift
//  GithubGists
//
//  Created by Vinicius Romani on 16/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation

extension GistViewModel {
    
    init(mapping model: Gist) {
        id = model.id
        name = model.files.first?.name ?? ""
        userImageURL = model.owner?.avatarURL
        userName = model.owner?.userName
    }
    
    static func array(mapping models: [Gist]) -> [GistViewModel] {
        return models.map { return GistViewModel(mapping: $0) }
    }
}
