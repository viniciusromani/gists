//
//  ListPublicGistModels.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 30/11/17.
//  Copyright (c) 2017 Vinicius Romani. All rights reserved.
//

import UIKit

struct ListPublicGist {
    struct FetchGists {
        struct Request { }
        struct Response {
            struct Success {
                let gists: [Gist]
            }
            struct APIError {
                let apiError: Error?
            }
        }
        struct ViewModel {
            struct Success {
                let displayedGists: [DisplayedGistCell]
            }
            struct Error {
                let errorTitle: String?
                let errorMessage: String?
                let actions: [UIAlertAction]?
            }
        }
    }
    
    struct DidSelectCell {
        struct Request {
            let indexPath: IndexPath
        }
        struct Response { }
        struct ViewModel { }
    }
}
