//
//  GistRespository.swift
//  GithubGists
//
//  Created by Vinicius Romani on 27/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import RxSwift

struct GistRespository: GistRespositoryController {
    let restApi: GistDataSource
    
    func retrievePublicGists() -> Observable<[Gist]> {
        return restApi.retrievePublicGists().mapGists()
    }
    
    func retrieveGist(withId id: String) -> Observable<Gist> {
        return restApi.retrieveGist(withId: id).mapGist()
    }
}
