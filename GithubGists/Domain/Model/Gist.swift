//
//  Gist.swift
//  GithubGists
//
//  Created by Vinicius Romani on 14/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Gist {
    let id: String?
    let description: String?
    let apiURL: String?
    let htmlURL: String?
    let file: File?
    let owner: User?
    let creationDate: Date?
    let totalComments: Int?
    let isPublic: Bool?
    let forksCounter: Int?
    
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
        forksCounter = 0
    }
}



