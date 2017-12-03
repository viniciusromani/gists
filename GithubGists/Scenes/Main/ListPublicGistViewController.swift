//
//  ListPublicGistViewController.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 30/11/17.
//  Copyright (c) 2017 Vinicius Romani. All rights reserved.
//

import UIKit

protocol ListPublicGistViewControllerInput {
    func displayPublicGistsSuccess(_ viewModel: ListPublicGist.FetchGists.ViewModel.Success)
    func displayPublicGistsError(_ viewModel: ListPublicGist.FetchGists.ViewModel.Error)
    
    func displaySelectedCell(_ viewModel: ListPublicGist.DidSelectCell.ViewModel)
}

protocol ListPublicGistViewControllerOutput {
    var selectedGistId: String? { get }
    
    func fetchPublicGists(_ request: ListPublicGist.FetchGists.Request)
    func didSelectCell(_ request: ListPublicGist.DidSelectCell.Request)
}

class ListPublicGistViewController: BaseViewController {
    
    var output: ListPublicGistViewControllerOutput!
    var router: ListPublicGistRouter!
    
    @IBOutlet weak var emptyStateView: UIView!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var gistsCollectionView: GistsCollectionView!
    
    // MARK: - Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        ListPublicGistConfigurator.sharedInstance.configure(viewController: self)
    }

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showActivityIndicator()
        fetchPublicGists()
        configure(gistCollection: gistsCollectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Event Handling
    
    @IBAction func reloadTouchedUpInside(_ sender: UIButton) {
        hideEmptyState()
        showActivityIndicator()
        fetchPublicGists()
    }
}

// MARK: - Display logic

extension ListPublicGistViewController: ListPublicGistViewControllerInput {
    
    // NOTE: Display the result from the Presenter
    
    func displayPublicGistsSuccess(_ viewModel: ListPublicGist.FetchGists.ViewModel.Success) {
        hideActivityIndicator()
        hideEmptyState()
        
        gistsCollectionView.displayedDataSource = viewModel.displayedGists
    }
    
    func displayPublicGistsError(_ viewModel: ListPublicGist.FetchGists.ViewModel.Error) {
        hideActivityIndicator()
        
        let errorAlert = AlertBuilder().setTitle(viewModel.errorTitle)
                                       .setMessage(viewModel.errorMessage)
                                       .setActions(viewModel.actions)
                                       .build()
        present(errorAlert, animated: true)
        showEmptyState()
    }
    
    func displaySelectedCell(_ viewModel: ListPublicGist.DidSelectCell.ViewModel) {
        router.navigateToGistDetail()
    }
}

// MARK: - GistsCollectionViewDelegate

extension ListPublicGistViewController: GistsCollectionViewDelegate {
    func configure(gistCollection collectionView: GistsCollectionView) {
        collectionView.register(UINib(nibName: GistCollectionViewCell.nibName, bundle: nil),
                                      forCellWithReuseIdentifier: gistsCollectionView.cellIdentifier)
        
        collectionView.dataSource = collectionView
        collectionView.delegate = collectionView
        
        collectionView.customDelegate = self
    }
    
    func didSelect(collectionView collection: UICollectionView, at indexPath: IndexPath) {
        didSelectCell(at: indexPath)
    }
}


// MARK: - Helpers

extension ListPublicGistViewController {
    private func fetchPublicGists() {
        let request = ListPublicGist.FetchGists.Request()
        output.fetchPublicGists(request)
    }
    
    private func didSelectCell(at indexPath: IndexPath) {
        let request = ListPublicGist.DidSelectCell.Request(indexPath: indexPath)
        output.didSelectCell(request)
    }
    
    private func showEmptyState() {
        emptyStateView.isHidden = false
        reloadButton.isHidden = false
    }
    
    private func hideEmptyState() {
        emptyStateView.isHidden = true
        reloadButton.isHidden = true
    }
}
