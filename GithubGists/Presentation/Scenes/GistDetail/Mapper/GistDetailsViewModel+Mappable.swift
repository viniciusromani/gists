//
//  GistDetailsViewModel+Mappable.swift
//  GithubGists
//
//  Created by Vinicius Romani on 24/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation

extension GistDetailsViewModel: MappableViewModel {
    
    typealias T = Gist
    
    init(mapping model: Gist) {
        name = model.files.first?.name ?? ""
        description = model.description ?? "-"
        url = model.htmlURL?.absoluteString ?? "-"
        language = model.files.first?.language ?? "-"
        forks = "1"
        ownerName = model.owner?.userName ?? "-"
        ownerGithubURL = model.owner?.userGithubURL?.absoluteString ?? "-"
    }
}
