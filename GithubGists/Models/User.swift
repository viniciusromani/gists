//
//  User.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 30/11/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    var id: Int?
    var userName: String?
    var userGithubURL: String?
    var avatarURL: String?
    
    init(with json: JSON?) {
        id = json?["id"].int
        userName = json?["login"].string
        userGithubURL = json?["html_url"].string
        avatarURL = json?["avatar_url"].string
    }
}
