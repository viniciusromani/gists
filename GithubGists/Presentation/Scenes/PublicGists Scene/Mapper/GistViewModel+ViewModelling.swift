//
//  GistViewModel+ViewModelling.swift
//  GithubGists
//
//  Created by Vinicius Romani on 23/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation

extension GistViewModel: ViewModellingProtocol {
    
    typealias T = Gist
    
    init(mapping model: Gist) {
        id = model.id
        name = model.files.first?.name ?? ""
        userImageURL = model.owner?.avatarURL
        userName = model.owner?.userName
    }
}

