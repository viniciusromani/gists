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
    
    func display(_ viewModel: [GistViewModel])
}

class PublicGistsViewController: UIViewController {
    
}

// MARK:- Display logic
extension PublicGistsViewController: PubicGistsViewProtocol {
    func display(_ viewModel: [GistViewModel]) {
        
    }
}
