//
//  File.swift
//  GithubGists
//
//  Created by Vinicius Romani on 14/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import SwiftyJSON

/*
 * Model Business rule:
 * It will be considered invalid if it does not have a name.
 * The name comes as key from service
 * JSON example:
 * "ring.erl": {
 *     "size": 932,
 *     "raw_url": "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl",
 *     "type": "text/plain",
 *     "language": "Erlang",
 *     "truncated": false,
 *     "content": "contents of gist"
 *  }
 */

struct File {
    let name: String
    let size: Double?
    let language: String?
    let url: String?
    
    init?(with json: JSON?) {
        guard let parseJSON = json else { return nil }
        guard let filename = parseJSON.dictionaryValue.keys.first, filename.count > 0 else { return nil }
        name = filename
        size = parseJSON.dictionaryValue["size"]?.double
        language = parseJSON.dictionaryValue["language"]?.string
        url = parseJSON.dictionaryValue["raw_url"]?.string
    }
}
