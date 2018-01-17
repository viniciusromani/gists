//
//  PublicGistsRouter.swift
//  GithubGists
//
//  Created by Vinicius Romani on 17/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation

protocol PublicGistsRouterProtocol: class {
    weak var view: PubicGistsViewProtocol! { get set }
    
}

class PublicGistsRouter: PublicGistsRouterProtocol {
    weak var view: PubicGistsViewProtocol!
    
}
