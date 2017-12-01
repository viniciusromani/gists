//
//  GistDetailConfigurator.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 30/11/17.
//  Copyright (c) 2017 Vinicius Romani. All rights reserved.
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension GistDetailViewController: GistDetailPresenterOutput {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue: segue)
    }
}

extension GistDetailInteractor: GistDetailViewControllerOutput {
}

extension GistDetailPresenter: GistDetailInteractorOutput {
}

class GistDetailConfigurator {
    // MARK: - Object lifecycle
    
    static let sharedInstance = GistDetailConfigurator()
    
    private init() {}
    
    // MARK: - Configuration
    
    func configure(viewController: GistDetailViewController) {
        let router = GistDetailRouter()
        router.viewController = viewController
        
        let presenter = GistDetailPresenter()
        presenter.output = viewController
        
        let interactor = GistDetailInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
