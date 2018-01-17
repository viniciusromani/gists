//
//  PublicGistsConfigurator.swift
//  GithubGists
//
//  Created by Vinicius Romani on 17/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import Swinject

struct PublicGistsConfigurator {
    static func configurePublicGistsScene(with container: Container) {
        container.storyboardInitCompleted(PublicGistsViewController.self) { (resolver, controller) in
            let presenter = PublicGistsPresenter()
            let router = PublicGistsRouter()
            
            presenter.view = controller
            presenter.retrievePublicGistsUseCase = resolver.resolve(RetrievePublicGistsUseCase.self)!
            
            router.view = controller
            
            controller.presenter = presenter
            controller.router = router
        }
    }
}
