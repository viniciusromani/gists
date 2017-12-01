//
//  ListPublicGistConfigurator.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 30/11/17.
//  Copyright (c) 2017 Vinicius Romani. All rights reserved.
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension ListPublicGistViewController: ListPublicGistPresenterOutput {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue: segue)
    }
}

extension ListPublicGistInteractor: ListPublicGistViewControllerOutput {
}

extension ListPublicGistPresenter: ListPublicGistInteractorOutput {
}

class ListPublicGistConfigurator {
    // MARK: - Object lifecycle
    
    static let sharedInstance = ListPublicGistConfigurator()
    
    private init() {}
    
    // MARK: - Configuration
    
    func configure(viewController: ListPublicGistViewController) {
        let router = ListPublicGistRouter()
        router.viewController = viewController
        
        let presenter = ListPublicGistPresenter()
        presenter.output = viewController
        
        let interactor = ListPublicGistInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
