//
//  GistDetailConfigurator.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 30/11/17.
//  Copyright (c) 2017 Vinicius Romani. All rights reserved.
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension GistDetailTableViewController: GistDetailPresenterOutput {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue: segue)
    }
}

extension GistDetailInteractor: GistDetailTableViewControllerOutput {
}

extension GistDetailPresenter: GistDetailInteractorOutput {
}

class GistDetailConfigurator {
    // MARK: - Object lifecycle
    
    static let sharedInstance = GistDetailConfigurator()
    
    private init() {}
    
    // MARK: - Configuration
    
    func configure(tableViewController: GistDetailTableViewController) {
        let router = GistDetailRouter()
        router.tableViewController = tableViewController
        
        let presenter = GistDetailPresenter()
        presenter.output = tableViewController
        
        let interactor = GistDetailInteractor()
        interactor.output = presenter
        
        tableViewController.output = interactor
        tableViewController.router = router
    }
}
