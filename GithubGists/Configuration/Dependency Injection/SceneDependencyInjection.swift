//
//  SceneDependencyInjection.swift
//  GithubGists
//
//  Created by Vinicius Romani on 17/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import Swinject

struct SceneDependencyInjection {
    static func registerScenes(with container: Container) {
        PublicGistsConfigurator.configurePublicGistsScene(with: container)
        GistDetailsConfigurator.configureGistDetailsScene(with: container)
    }
}
