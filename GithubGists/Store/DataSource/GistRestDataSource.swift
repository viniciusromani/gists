//
//  GistRestDataSource.swift
//  GithubGists
//
//  Created by Vinicius Romani on 27/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import Moya
import RxSwift

struct GistRestDataSource: GistDataSource {
    let provider = MoyaProvider<GithubGist>()
    
    func retrievePublicGists() -> Observable<GistEntity> {
        return provider.rx.request(.publicGists)
            .asObservable()
            .debug()
            .filterSuccessfulStatusCodes()
            .catchHTTPError()
            .mapEntity(GistEntity.self)
    }
    
    func retrieveGist(withId id: String) -> Observable<GistEntity> {
        return provider.rx.request(.specificGist(gistId: id))
            .asObservable()
            .debug()
            .filterSuccessfulStatusCodes()
            .catchHTTPError()
            .mapEntity(GistEntity.self)
    }
}

