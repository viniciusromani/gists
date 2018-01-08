//
//  GistRespositoryController.swift
//  GithubGists
//
//  Created by Vinicius Romani on 27/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import RxSwift

protocol GistRespositoryController {
    func retrievePublicGists() -> Observable<[Gist]>
    func retrieveGist(withId id: String) -> Observable<Gist>
}


