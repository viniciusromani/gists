//
//  GistDetailsRouter.swift
//  GithubGists
//
//  Created by Vinicius Romani on 23/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation

protocol GistDetailsRouterProtocol: class {
    weak var viewController: GistDetailsViewController! { get set }
    
}

class GistDetailsRouter: GistDetailsRouterProtocol {
    var viewController: GistDetailsViewController!
    
}
