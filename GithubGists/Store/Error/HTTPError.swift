//
//  HTTPError.swift
//  GithubGists
//
//  Created by Vinicius Romani on 20/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import Moya

enum HTTPError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case timeOut
    case unreachable
}

extension HTTPError {
    init(mapping urlError: URLError) throws {
        switch urlError.code.rawValue {
        case -1001: self = .timeOut
        case -1009, -1022: self = .unreachable
        case 404: self = .notFound
        case 400: self = .badRequest
        case 401: self = .unauthorized
        case 403: self = .forbidden
        default: throw urlError
        }
    }
    
    init(mapping moyaError: MoyaError) throws {
        switch moyaError {
        case .statusCode(let response):
            switch response.statusCode {
            case -1001: self = .timeOut
            case -1009: self = .unreachable
            case 404: self = .notFound
            case 400: self = .badRequest
            case 401: self = .unauthorized
            case 403: self = .forbidden
            default: throw moyaError
            }
        case .underlying(let error, _):
            guard let urlError = error as? URLError else { throw error }
            self = try HTTPError(mapping: urlError)
        default:
            throw moyaError
        }
    }
}

