//
//  GistDataSource.swift
//  GithubGists
//
//  Created by Vinicius Romani on 27/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import RxSwift

protocol GistDataSource {
    func retrievePublicGists() -> Observable<GistEntity>
    func retrieveGist(withId id: String) -> Observable<GistEntity>
}
