//
//  Gist.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 30/11/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import SwiftyJSON

class Gist {
    var id: String?
    var description: String?
    var apiURL: String?
    var htmlURL: String?
    var file: File?
    var owner: User?
    var creationDate: Date?
    var totalComments: Int?
    var isPublic: Bool?
    var forksCounter: Int?
    
    init(with json: JSON?) {
        id = json?["id"].string
        description = json?["description"].string
        apiURL = json?["url"].string
        htmlURL = json?["html_url"].string
        file = File(with: json?["files"])
        owner = User(with: json?["owner"])
        creationDate = Date()
        totalComments = json?["comments"].int
        isPublic = json?["public"].bool
    }
}

