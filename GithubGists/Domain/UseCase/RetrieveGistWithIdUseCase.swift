//
//  RetrieveGistWithIdUseCase.swift
//  GithubGists
//
//  Created by Vinicius Romani on 04/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import RxSwift

struct RetrieveGistWithIdUseCase {
    let controller: GistRespositoryController
    
    func retrieveGist(withId id: String) -> Observable<Gist> {
        return controller.retrieveGist(withId: id).catchGistWithIdError()
    }
}
