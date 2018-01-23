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
    
    lazy var adapter = PublicGistsAdapter(collectionView: publicGistsCollectionView, viewDelegate: self)
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var publicGistsCollectionView: UICollectionView!
    
    // MARK: - ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.retrievePublicGists()
    }
}

// MARK: - Display logic

extension PublicGistsViewController: PubicGistsViewProtocol {
    func display(_ viewModel: PublicGistsViewModel) {
        adapter.setDataSet(viewModel.gists)
    }
}

// MARK: - CollectionAdapterView Protocol

extension PublicGistsViewController: PublicGistsAdapterViewProtocol {
    func didSelect(gist gistViewModel: GistViewModel) {
        let gistId = gistViewModel.id
        router.navigateToDetails(withId: gistId)
    }
}






