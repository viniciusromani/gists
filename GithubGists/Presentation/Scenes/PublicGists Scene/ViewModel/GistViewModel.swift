//
//  GistViewModel.swift
//  GithubGists
//
//  Created by Vinicius Romani on 16/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation

struct GistViewModel {
    let id: String
    let name: String
    let userImageURL: URL?
    let userName: String
}

struct PublicGistsViewModel {
    let gists: [GistViewModel]
}
