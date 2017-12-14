//
//  File.swift
//  GithubGists
//
//  Created by Vinicius Romani on 14/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import SwiftyJSON

struct File {
    let name: String?
    let size: Double?
    let language: String?
    
    init(with json: JSON?) {
        let jsonDictionary = json?[json?.dictionaryValue.keys.first ?? ""]
        name = jsonDictionary?["filename"].string
        size = jsonDictionary?["size"].double
        language = jsonDictionary?["language"].string
    }
}
