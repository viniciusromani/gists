//
//  GistDetailInteractor.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 30/11/17.
//  Copyright (c) 2017 Vinicius Romani. All rights reserved.
//

import UIKit

protocol GistDetailInteractorInput {
    var selectedGistId: String? { get }
    
    func fetchGist(_ request: GistDetail.FetchGist.Request)
}

protocol GistDetailInteractorOutput {
    func presentGistSuccess(_ response: GistDetail.FetchGist.Response.Success)
    func presentGistError(_ response: GistDetail.FetchGist.Response.APIError)
}

class GistDetailInteractor: GistDetailInteractorInput {
    var output: GistDetailInteractorOutput!
    var gistsWorker = GistWorker(store: GistRestStore())
    var selectedGistId: String?
    
    // MARK: - Business logic
    
    func fetchGist(_ request: GistDetail.FetchGist.Request) {
        gistsWorker.fetchGist(with: selectedGistId ?? "", successHandler: { [weak self] gist in
            guard let weakSelf = self else { return }
            let response = GistDetail.FetchGist.Response.Success(gist: gist)
            weakSelf.output.presentGistSuccess(response)
        }) { [weak self] error in
            guard let weakSelf = self else { return }
            let response = GistDetail.FetchGist.Response.APIError(apiError: error)
            weakSelf.output.presentGistError(response)
        }
    }
}
