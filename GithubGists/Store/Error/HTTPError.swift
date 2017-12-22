//
//  HTTPError.swift
//  GithubGists
//
//  Created by Vinicius Romani on 20/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation

enum HTTPError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case unacceptable
    case timeOut
    case noInternet
}
