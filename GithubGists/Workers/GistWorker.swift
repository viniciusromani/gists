//
//  GistWorker.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 29/11/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation

class GistWorker {
    
    var store: GistStoreProtocol
    
    init(store: GistStoreProtocol) {
        self.store = store
    }
    
    func fetchPublicGists(successHandler: @escaping (_ gists: [Gist]) -> Void,
                          errorHandler: @escaping(_ error: Error?) -> Void) {
        store.fetchPublicGists(successHandler: successHandler, errorHandler: errorHandler)
    }
    
    func fetchGist(with id: String,
                   successHandler: @escaping (_ gist: Gist) -> Void,
                   errorHandler: @escaping(_ error: Error?) -> Void) {
        store.fetchGist(with: id, successHandler: successHandler, errorHandler: errorHandler)
    }
}

protocol GistStoreProtocol {
    func fetchPublicGists(successHandler: @escaping (_ gists: [Gist]) -> Void,
                          errorHandler: @escaping(_ error: Error?) -> Void)
    func fetchGist(with id: String,
                   successHandler: @escaping (_ gist: Gist) -> Void,
                   errorHandler: @escaping(_ error: Error?) -> Void)
}
