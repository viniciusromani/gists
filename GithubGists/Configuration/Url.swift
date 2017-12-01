//
//  Url.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 30/11/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation

struct Url {
    
    private static let BASE = "https://api.github.com/"
    
    struct GIST {
        private static let RESOURCE = "gists/"
        
        static let PUBLIC = "\(BASE)\(GIST.RESOURCE)public"
        static let GET_BY_ID = "\(BASE)\(GIST.RESOURCE)"
    }
}
