//
//  ListPublicGistPresenter.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 30/11/17.
//  Copyright (c) 2017 Vinicius Romani. All rights reserved.
//

import UIKit

protocol ListPublicGistPresenterInput {
    func presentPublicGistsSuccess(_ response: ListPublicGist.FetchGists.Response.Success)
    func presentPublicGistsError(_ response: ListPublicGist.FetchGists.Response.APIError)
    
    func presentSelectedCell(_ response: ListPublicGist.DidSelectCell.Response)
}

protocol ListPublicGistPresenterOutput: class {
    func displayPublicGistsSuccess(_ viewModel: ListPublicGist.FetchGists.ViewModel.Success)
    func displayPublicGistsError(_ viewModel: ListPublicGist.FetchGists.ViewModel.Error)
    
    func displaySelectedCell(_ viewModel: ListPublicGist.DidSelectCell.ViewModel)
}

class ListPublicGistPresenter: ListPublicGistPresenterInput {
    weak var output: ListPublicGistPresenterOutput!
    
    // MARK: - Presentation logic
    
    // NOTE: Format the response from the Interactor and pass the result back to the View Controller
    
    func presentPublicGistsSuccess(_ response: ListPublicGist.FetchGists.Response.Success) {
        let displayedCells = getDisplayedGistCells(from: response.gists)
        let viewModel = ListPublicGist.FetchGists.ViewModel.Success(displayedGists: displayedCells)
        output.displayPublicGistsSuccess(viewModel)
    }
    
    func presentPublicGistsError(_ response: ListPublicGist.FetchGists.Response.APIError) {
        if let error = response.apiError {
            let okAction = AlertActionBuilder(dismissWithTitle: "Ok").build()
            let viewModel = ListPublicGist.FetchGists.ViewModel.Error(errorTitle: "Error",
                                                                      errorMessage: error.localizedDescription,
                                                                      actions: [okAction])
            output.displayPublicGistsError(viewModel)
        }
    }
    
    func presentSelectedCell(_ response: ListPublicGist.DidSelectCell.Response) {
        let viewModel = ListPublicGist.DidSelectCell.ViewModel()
        output.displaySelectedCell(viewModel)
    }
}

// MARK: - Helpers

extension ListPublicGistPresenter {
    func getDisplayedGistCells(from gists: [Gist]) -> [DisplayedGistCell] {
        var displayedCells: [DisplayedGistCell] = []
        for gist in gists {
            let url = gist.owner?.avatarURL
            let displayedCell = DisplayedGistCell(fileName: gist.file?.name ?? "-",
                                                  ownerImageURL: url != nil ? URL(string: url!): nil,
                                                  userName: gist.owner?.userName ?? "-")
            displayedCells.append(displayedCell)
        }
        
        return displayedCells
    }
}



