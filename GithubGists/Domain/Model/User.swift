//
//  User.swift
//  GithubGists
//
//  Created by Vinicius Romani on 14/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    let id: Int?
    let userName: String?
    let userGithubURL: String?
    let avatarURL: String?
    
    init?(with json: JSON?) {
        guard let parseId = json?["id"].int else { return nil }
        id = parseId
        userName = json?["login"].string
        userGithubURL = json?["html_url"].string
        avatarURL = json?["avatar_url"].string
    }
}
