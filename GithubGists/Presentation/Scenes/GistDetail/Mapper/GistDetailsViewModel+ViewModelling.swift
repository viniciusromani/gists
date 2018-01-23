//
//  GistDetailsViewModel+ViewModelling.swift
//  GithubGists
//
//  Created by Vinicius Romani on 23/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation

extension GistDetailsViewModel {
    
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
