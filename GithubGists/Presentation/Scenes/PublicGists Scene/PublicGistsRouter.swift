//
//  PublicGistsRouter.swift
//  GithubGists
//
//  Created by Vinicius Romani on 17/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import UIKit

protocol PublicGistsRouterProtocol: class {
    weak var viewController: PublicGistsViewController! { get set }
    
    func navigateToDetails(withId id: String)
}

class PublicGistsRouter: PublicGistsRouterProtocol {
    weak var viewController: PublicGistsViewController!
    
    let detailsSegueIdentifier = R.segue.publicGistsViewController.showGistDetail
    
    func navigateToDetails(withId id: String) {
        viewController.performSegue(withIdentifier: detailsSegueIdentifier, sender: id)
    }
}

extension PublicGistsViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.publicGistsViewController.showGistDetail.identifier {
            passDataToDetails(segue, sender: sender)
        }
    }
    
    private func passDataToDetails(_ segue: UIStoryboardSegue, sender: Any?) {
        guard let gistDetailsScene = R.segue.publicGistsViewController.showGistDetail(segue: segue),
            let selectedId = sender as? String else { return }
        gistDetailsScene.destination.presenter.selectedGistId = selectedId
    }
}


