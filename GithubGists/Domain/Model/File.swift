//
//  File.swift
//  GithubGists
//
//  Created by Vinicius Romani on 19/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation

/*
 * Domain Business rule:
 * It will be considered invalid if size attribute is 0 or less.
 * PS. The rule will be applied when mapping an entity to a model.
 */

struct File {
    let name: String
    let size: Double
    let language: String?
    let url: URL?
}
