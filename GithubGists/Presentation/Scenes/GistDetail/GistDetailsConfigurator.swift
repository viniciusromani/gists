//
//  GistDetailConfigurator.swift
//  GithubGists
//
//  Created by Vinicius Romani on 05/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import Swinject

struct GistDetailsConfigurator {
    static func configureGistDetailsScene(with container: Container) {
        container.storyboardInitCompleted(GistDetailsViewController.self) { (resolver, controller) in
            let presenter = GistDetailsPresenter()
            let router = GistDetailsRouter()
            
            presenter.view = controller
            presenter.retrieveGistWithIdUseCase = resolver.resolve(RetrieveGistWithIdUseCase.self)!
            
            router.viewController = controller
            
            controller.presenter = presenter
            controller.router = router
        }
    }
}



