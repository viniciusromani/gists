//
//  GistDetailPresenter.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 30/11/17.
//  Copyright (c) 2017 Vinicius Romani. All rights reserved.
//

import UIKit

protocol GistDetailPresenterInput {
    func presentGistSuccess(_ response: GistDetail.FetchGist.Response.Success)
    func presentGistError(_ response: GistDetail.FetchGist.Response.APIError)
}

protocol GistDetailPresenterOutput: class {
    func displayGistSuccess(_ viewModel: GistDetail.FetchGist.ViewModel.Success)
    func displayGistError(_ viewModel: GistDetail.FetchGist.ViewModel.Error)
}

class GistDetailPresenter: GistDetailPresenterInput {
    weak var output: GistDetailPresenterOutput!
    
    // MARK: - Presentation logic
    
    func presentGistSuccess(_ response: GistDetail.FetchGist.Response.Success) {
        let displayedGistDetail = getDisplayedGistDetail(from: response.gist)
        let viewModel = GistDetail.FetchGist.ViewModel.Success(displayedGistDetail: displayedGistDetail)
        output.displayGistSuccess(viewModel)
    }
    
    func presentGistError(_ response: GistDetail.FetchGist.Response.APIError) {
        if let error = response.apiError {
            let viewModel = GistDetail.FetchGist.ViewModel.Error(errorMessage: error.localizedDescription)
            output.displayGistError(viewModel)
        }
    }
}

// MARK: - Helpers

extension GistDetailPresenter {
    func getDisplayedGistDetail(from gist: Gist) -> GistDetail.DisplayedGistDetail {
        typealias DisplayedGistDetail = GistDetail.DisplayedGistDetail
        let displayedGistDetail = DisplayedGistDetail(filename: gist.file?.name ?? "",
                                                      description: gist.description,
                                                      gistURL: gist.htmlURL ?? "",
                                                      language: gist.file?.language ?? "",
                                                      forksCounter: String(gist.forksCounter ?? 0),
                                                      ownerName: gist.owner?.userName ?? "",
                                                      ownerGithubURL: gist.owner?.userGithubURL ?? "")
        return displayedGistDetail
    }
}



