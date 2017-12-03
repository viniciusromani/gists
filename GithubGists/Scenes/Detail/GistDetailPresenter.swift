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
        let displayedGistDetail = getDisplayedCells(from: response.gist)
        let viewModel = GistDetail.FetchGist.ViewModel.Success(filename: response.gist.file?.name ?? "-",
                                                               displayedGistDetail: displayedGistDetail)
        output.displayGistSuccess(viewModel)
    }
    
    func presentGistError(_ response: GistDetail.FetchGist.Response.APIError) {
        if let error = response.apiError {
            let okAction = AlertActionBuilder(dismissWithTitle: "Ok").build()
            let viewModel = GistDetail.FetchGist.ViewModel.Error(errorTitle: "Error",
                                                                 errorMessage: error.localizedDescription,
                                                                 actions: [okAction])
            output.displayGistError(viewModel)
        }
    }
}

// MARK: - Helpers

extension GistDetailPresenter {
    
    func getDisplayedCells(from gist: Gist) -> [DisplayedSingleInformationCell] {
        let descriptionTuple = createDescriptionTuple(gist.description)
        let urlTuple = createURLTuple(gist.htmlURL)
        let languageTuple = createLanguageTuple(gist.file?.language)
        let forksTuple = createForksTuple(String(gist.forksCounter ?? 0))
        let ownerTuple = createOwnerTuple(gist.owner?.userName)
        let ownerGithubTuple = createOwnerGithubURLTuple(gist.owner?.userGithubURL)
        return [descriptionTuple, urlTuple, languageTuple, forksTuple, ownerTuple, ownerGithubTuple]
    }
    
    private func createDescriptionTuple(_ desc: String?) -> DisplayedSingleInformationCell {
        return DisplayedSingleInformationCell(description: "Description", content: desc ?? "-")
    }
    private func createURLTuple(_ url: String?) -> DisplayedSingleInformationCell {
        return DisplayedSingleInformationCell(description: "URL", content: url ?? "-")
    }
    private func createLanguageTuple(_ language: String?) -> DisplayedSingleInformationCell {
        return DisplayedSingleInformationCell(description: "Language", content: language ?? "-")
    }
    private func createForksTuple(_ forks: String?) -> DisplayedSingleInformationCell {
        return DisplayedSingleInformationCell(description: "Forks", content: forks ?? "-")
    }
    private func createOwnerTuple(_ owner: String?) -> DisplayedSingleInformationCell {
        return DisplayedSingleInformationCell(description: "Owner", content: owner ?? "-")
    }
    private func createOwnerGithubURLTuple(_ githubURL: String?) -> DisplayedSingleInformationCell {
        return DisplayedSingleInformationCell(description: "Owner Github URL", content: githubURL ?? "-")
    }
}



