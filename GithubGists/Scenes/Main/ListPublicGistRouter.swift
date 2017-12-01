//
//  ListPublicGistRouter.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 30/11/17.
//  Copyright (c) 2017 Vinicius Romani. All rights reserved.
//

import UIKit

protocol ListPublicGistRouterInput {
    func navigateToGistDetail()
}

class ListPublicGistRouter: ListPublicGistRouterInput {
    weak var viewController: ListPublicGistViewController!
    
    let showDetailIdentifier = "showGistDetailIdentifier"
    
    // MARK: - Navigation
    
    func navigateToGistDetail() {
        viewController.performSegue(withIdentifier: showDetailIdentifier, sender: nil)
    }
    
    // MARK: - Communication
    
    func passDataToNextScene(segue: UIStoryboardSegue) {
        // NOTE: Teach the router which scenes it can communicate with
        
        if segue.identifier == showDetailIdentifier {
            passDataToDetailScene(segue: segue)
        }
    }
    
    private func passDataToDetailScene(segue: UIStoryboardSegue) {
        guard let detailViewController = segue.destination as? GistDetailTableViewController else { return }
        detailViewController.output.selectedGistId = viewController.output.selectedGistId
    }
}
