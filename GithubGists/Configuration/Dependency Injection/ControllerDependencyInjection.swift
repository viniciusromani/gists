//
//  ControllerDependencyInjection.swift
//  GithubGists
//
//  Created by Vinicius Romani on 17/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import Swinject

struct ControllerDependencyInjection {
    static func registerControllers(with container: Container) {
        container.register(GistRespository.self) { resolver -> GistRespository in
            return GistRespository(restApi: resolver.resolve(GistRestDataSource.self)!)
        }
    }
}
