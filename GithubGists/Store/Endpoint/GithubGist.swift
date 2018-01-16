//
//  GithubGist.swift
//  GithubGists
//
//  Created by Vinicius Romani on 27/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import Moya

enum GithubGist {
    case publicGists
    case specificGist(gistId: String)
}

extension GithubGist: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.github.com/gists/")!
    }
    
    var path: String {
        switch self {
        case .publicGists: return "public"
        case .specificGist(let gistId): return gistId
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .publicGists: return .get
        case .specificGist: return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .publicGists:
            guard let path = Bundle().url(forResource: "public", withExtension: "json") else { return Data() }
            do {
                return try Data(contentsOf: path)
            } catch {
                return Data()
            }
        case .specificGist:
            guard let path = Bundle().url(forResource: "specific", withExtension: "json") else { return Data() }
            do {
                return try Data(contentsOf: path)
            } catch {
                return Data()
            }
        }
    }
    
    var task: Task {
        switch self {
        case .publicGists: return .requestPlain
        case .specificGist: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
