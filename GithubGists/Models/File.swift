//
//  File.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 30/11/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import SwiftyJSON

class File {
    var name: String?
    var size: Double?
    var language: String?
    
    init(with json: JSON?) {
        let jsonDictionary = json?[json?.dictionaryValue.keys.first ?? ""]
        name = jsonDictionary?["filename"].string
        size = jsonDictionary?["size"].double
        language = jsonDictionary?["language"].string
    }
}
