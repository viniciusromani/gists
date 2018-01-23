//
//  UseCaseDependencyInjection.swift
//  GithubGists
//
//  Created by Vinicius Romani on 17/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import Swinject

struct UseCaseDependencyInjection {
    static func registerUseCases(with container: Container) {
        container.register(RetrievePublicGistsUseCase.self) { resolver -> RetrievePublicGistsUseCase in
            return RetrievePublicGistsUseCase(controller: resolver.resolve(GistRespository.self)!)
        }
        
        container.register(RetrieveGistWithIdUseCase.self) { resolver -> RetrieveGistWithIdUseCase in
            return RetrieveGistWithIdUseCase(controller: resolver.resolve(GistRespository.self)!)
        }
    }
}
