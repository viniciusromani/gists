//
//  GistRestStore.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 30/11/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation

class GistRestStore: GistStoreProtocol {
    
    func fetchPublicGists(successHandler: @escaping (_ gists: [Gist]) -> Void,
                          errorHandler: @escaping(_ error: Error?) -> Void) {
        
        let path = Url.GIST.PUBLIC
        
        WebServiceHelper.requestWithMethod(.get, path: path, completionSuccess: { result in
            
            let resultArray = result.arrayValue
            var gists: [Gist] = []
            for json in resultArray {
                let gist = Gist(with: json)
                gists.append(gist)
            }
            
            successHandler(gists)
            
        }) { (error) in
            
            errorHandler(error)
        }
    }
    
    func fetchGist(with id: String,
                   successHandler: @escaping (_ gist: Gist) -> Void,
                   errorHandler: @escaping(_ error: Error?) -> Void) {
        
        let path = Url.GIST.GET_BY_ID.appending(id)
        
        WebServiceHelper.requestWithMethod(.get, path: path, completionSuccess: { result in
            
            let gist = Gist(with: result)
            successHandler(gist)
        }) { (error) in
            
            errorHandler(error)
        }
    }
}
