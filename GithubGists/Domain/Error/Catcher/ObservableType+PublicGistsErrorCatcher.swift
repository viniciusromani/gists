//
//  ObservableType+PublicGistsErrorCatcher.swift
//  GithubGists
//
//  Created by Vinicius Romani on 04/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import RxSwift

extension RetrievePublicGistsError {
    init(mappingRetrieve error: Error) throws {
        switch error {
        case is HTTPError, is JSONError: self = .unableToRetrieve
        default: throw error
        }
    }
}

extension ObservableType where E == Array<Gist> {
    func catchPublicGistsError() -> Observable<[Gist]> {
        let error = catchError { error -> Observable<[Gist]> in
            guard let unableToRetrieveError = try? RetrievePublicGistsError(mappingRetrieve: error) else {
                return Observable.error(error)
            }
            return Observable.error(unableToRetrieveError)
        }
        return error
    }
}
