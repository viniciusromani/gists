//
//  JSONError.swift
//  GithubGists
//
//  Created by Vinicius Romani on 20/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation

enum JSONError: Error {
    case malformed
    case typeMismatch
    case keyNotFound
    case valueNotFound
    case cannotMapToEntity
    case cannotMapToModel
}
