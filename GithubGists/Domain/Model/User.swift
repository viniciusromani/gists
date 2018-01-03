//
//  User.swift
//  GithubGists
//
//  Created by Vinicius Romani on 19/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation

/*
 * No Domain Business rule:
 */

struct User {
    let id: String
    let userName: String?
    let userGithubURL: URL?
    let avatarURL: URL?
}
