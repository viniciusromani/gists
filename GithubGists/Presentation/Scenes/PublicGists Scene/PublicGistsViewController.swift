//
//  PublicGistsViewController.swift
//  GithubGists
//
//  Created by Vinicius Romani on 16/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import UIKit

protocol PubicGistsViewProtocol: class {
    var presenter: PublicGistsPresenterProtocol! { get set }
    var router: PublicGistsRouterProtocol! { get set }
    
    func display(_ viewModel: [GistViewModel])
}

class PublicGistsViewController: UIViewController {
    var presenter: PublicGistsPresenterProtocol!
    var router: PublicGistsRouterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.retrievePublicGists()
    }
}

// MARK:- Display logic
extension PublicGistsViewController: PubicGistsViewProtocol {
    func display(_ viewModel: [GistViewModel]) {
        
    }
}
