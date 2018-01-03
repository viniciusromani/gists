//
//  Gist.swift
//  GithubGists
//
//  Created by Vinicius Romani on 19/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation

/*
 * Domain Business rule:
 * It will be considered invalid if it does not have any files related.
 * PS. The rule will be applied when mapping an entity to a model.
 */

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
