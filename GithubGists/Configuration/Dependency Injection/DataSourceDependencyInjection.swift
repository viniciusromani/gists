//
//  DataSourceDependencyInjection.swift
//  GithubGists
//
//  Created by Vinicius Romani on 17/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import Swinject

struct DataSourceDependencyInjection {
    static func registerDataSources(with container: Container) {
        container.register(GistRestDataSource.self) { resolver -> GistRestDataSource in
            return GistRestDataSource()
        }
    }
}
