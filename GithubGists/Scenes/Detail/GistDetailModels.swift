//
//  GistDetailModels.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 30/11/17.
//  Copyright (c) 2017 Vinicius Romani. All rights reserved.
//

import UIKit

struct GistDetail {
    
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
                let filename: String
                let displayedGistDetail: [DisplayedSingleInformationCell]
            }
            struct Error {
                let errorMessage: String
            }
        }
    }
}
