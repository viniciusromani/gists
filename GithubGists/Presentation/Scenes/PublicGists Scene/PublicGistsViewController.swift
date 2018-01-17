//
//  PublicGistsViewController.swift
//  GithubGists
//
//  Created by Vinicius Romani on 16/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import UIKit

// MARK: - View Protocol

protocol PubicGistsViewProtocol: class {
    var presenter: PublicGistsPresenterProtocol! { get set }
    var router: PublicGistsRouterProtocol! { get set }
    
    func display(_ viewModel: PublicGistsViewModel)
}

// MARK: - ViewController

class PublicGistsViewController: UIViewController {
    
    var presenter: PublicGistsPresenterProtocol!
    var router: PublicGistsRouterProtocol!
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var publicGistsCollectionView: PublicGistsCollectionView!
    
    // MARK: - ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        
        presenter.retrievePublicGists()
    }
}

// MARK: - Display logic

extension PublicGistsViewController: PubicGistsViewProtocol {
    func display(_ viewModel: PublicGistsViewModel) {
        publicGistsCollectionView.displayedGists = viewModel.gists
    }
}

// MARK: - Helper

extension PublicGistsViewController {
    
    private func configureCollectionView() {
        publicGistsCollectionView.delegate = publicGistsCollectionView
        publicGistsCollectionView.dataSource = publicGistsCollectionView
    }
}





