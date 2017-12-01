//
//  ListPublicGistInteractor.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 30/11/17.
//  Copyright (c) 2017 Vinicius Romani. All rights reserved.
//

import UIKit

protocol ListPublicGistInteractorInput {
    var selectedGistId: String? { get set }
    
    func fetchPublicGists(_ request: ListPublicGist.FetchGists.Request)
    func didSelectCell(_ request: ListPublicGist.DidSelectCell.Request)
}

protocol ListPublicGistInteractorOutput {
    func presentPublicGistsSuccess(_ response: ListPublicGist.FetchGists.Response.Success)
    func presentPublicGistsError(_ response: ListPublicGist.FetchGists.Response.APIError)
    
    func presentSelectedCell(_ response: ListPublicGist.DidSelectCell.Response)
}

class ListPublicGistInteractor: ListPublicGistInteractorInput {
    
    var output: ListPublicGistInteractorOutput!
    var selectedGistId: String?
    
    var gistsWorker = GistWorker(store: GistRestStore())
    
    private var shownGists: [Gist] = []
    
    // MARK: - Business logic
    
    // NOTE: Create some Worker to do the work
    // NOTE: Pass the result to the Presenter
    
    func fetchPublicGists(_ request: ListPublicGist.FetchGists.Request) {
        
        gistsWorker.fetchPublicGists(successHandler: { [weak self] publicGists in
            guard let weakSelf = self else { return }
            
            weakSelf.shownGists = publicGists
            let response = ListPublicGist.FetchGists.Response.Success(gists: publicGists)
            weakSelf.output.presentPublicGistsSuccess(response)
            
        }) { [weak self] apiError in
            guard let weakSelf = self else { return }
            
            let response = ListPublicGist.FetchGists.Response.APIError(apiError: apiError)
            weakSelf.output.presentPublicGistsError(response)
        }
    }
    
    func didSelectCell(_ request: ListPublicGist.DidSelectCell.Request) {
        let selectedGist = shownGists[request.indexPath.row]
        selectedGistId = selectedGist.id
        
        let response = ListPublicGist.DidSelectCell.Response()
        output.presentSelectedCell(response)
    }
}
