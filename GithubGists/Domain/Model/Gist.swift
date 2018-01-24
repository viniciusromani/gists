//
//  Gist.swift
//  GithubGists
//
//  Created by Vinicius Romani on 19/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation

struct Gist {
    let id: String
    let description: String?
    let apiURL: URL?
    let htmlURL: URL?
    var files: [File]
    let owner: User?
    let isPublic: Bool?
    let createdAt: Date?
}
