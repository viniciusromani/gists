//
//  RetrievePublicGistsUseCase.swift
//  GithubGists
//
//  Created by Vinicius Romani on 04/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import RxSwift

struct RetrievePublicGistsUseCase {
    let controller: GistRespositoryController
    
    func retrievePublicGists() -> Observable<[Gist]> {
        return controller.retrievePublicGists().catchPublicGistsError()
    }
}
