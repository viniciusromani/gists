//
//  File.swift
//  GithubGists
//
//  Created by Vinicius Romani on 14/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation

/*
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

struct FileEntity {
    let name: String
    let size: Double
    let language: String?
    let url: String?
}

