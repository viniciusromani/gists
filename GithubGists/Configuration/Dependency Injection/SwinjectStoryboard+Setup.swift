//
//  SwinjectStoryboard+Setup.swift
//  GithubGists
//
//  Created by Vinicius Romani on 17/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import SwinjectStoryboard
import Swinject

extension SwinjectStoryboard {
    @objc class func setup() {
        DataSourceDependencyInjection.registerDataSources(with: defaultContainer)
        ControllerDependencyInjection.registerControllers(with: defaultContainer)
        UseCaseDependencyInjection.registerUseCases(with: defaultContainer)
        SceneDependencyInjection.registerScenes(with: defaultContainer)
    }
}
