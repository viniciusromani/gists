//
//  GistDetailModels.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 30/11/17.
//  Copyright (c) 2017 Vinicius Romani. All rights reserved.
//

import UIKit

struct GistDetail {
    struct DisplayedGistDetail {
        let filename: String?
        let description: String?
        let gistURL: String?
        let language: String?
        let forksCounter: String?
        let ownerName: String?
        let ownerGithubURL: String?
    }
    
    struct FetchGist {
        struct Request { }
        struct Response {
            struct Success {
                let gist: Gist
            }
            struct APIError {
                let apiError: Error?
            }
        }
        struct ViewModel {
            struct Success {
                var displayedGistDetail: DisplayedGistDetail
            }
            struct Error {
                let errorMessage: String
            }
        }
    }
}
