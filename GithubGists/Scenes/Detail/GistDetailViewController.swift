//
//  GistDetailViewController.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 30/11/17.
//  Copyright (c) 2017 Vinicius Romani. All rights reserved.
//

import UIKit

protocol GistDetailViewControllerInput {
    func displayGistSuccess(_ viewModel: GistDetail.FetchGist.ViewModel.Success)
    func displayGistError(_ viewModel: GistDetail.FetchGist.ViewModel.Error)
}

protocol GistDetailViewControllerOutput {
    var selectedGistId: String? { get set }
    
    func fetchGist(_ request: GistDetail.FetchGist.Request)
}

class GistDetailViewController: BaseViewController {
    var output: GistDetailViewControllerOutput!
    var router: GistDetailRouter!
    
    @IBOutlet weak var filenameLabel: UILabel!
    @IBOutlet weak var gistDetailTableView: GistDetailTableView!
    @IBOutlet weak var emptyStateView: UIView!
    
    // MARK: - Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        GistDetailConfigurator.sharedInstance.configure(viewController: self)
    }

    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showActivityIndicator()
        fetchSelectedGist()
        configure(gistTableView: gistDetailTableView)
    }
}

// MARK: - Display logic

extension GistDetailViewController: GistDetailViewControllerInput {
    
    func displayGistSuccess(_ viewModel: GistDetail.FetchGist.ViewModel.Success) {
        hideActivityIndicator()
        hideEmptyState()
        
        filenameLabel.text = viewModel.filename
        gistDetailTableView.displayedDataSource = viewModel.displayedGistDetail
    }
    
    func displayGistError(_ viewModel: GistDetail.FetchGist.ViewModel.Error) {
        hideActivityIndicator()
        
        let errorAlert = AlertBuilder().setTitle(viewModel.errorTitle)
                                       .setMessage(viewModel.errorMessage)
                                       .setActions(viewModel.actions)
                                       .build()
        present(errorAlert, animated: true)
        showEmptyState()
    }
}

// MARK: - GistDetailTableViewDelegate

extension GistDetailViewController: GistDetailTableViewDelegate {
    func configure(gistTableView tableView: GistDetailTableView) {
        tableView.register(UINib(nibName: SingleInformationTableViewCell.nibName, bundle: nil),
                           forCellReuseIdentifier: gistDetailTableView.cellIdentifier)
        
        tableView.dataSource = tableView
        tableView.delegate = tableView
        
        tableView.customDelegate = self
    }
}

// MARK: - Helpers

extension GistDetailViewController {
    private func fetchSelectedGist() {
        let request = GistDetail.FetchGist.Request()
        output.fetchGist(request)
    }
    
    private func showEmptyState() {
        emptyStateView.isHidden = false
        filenameLabel.isHidden = true
    }
    
    private func hideEmptyState() {
        emptyStateView.isHidden = true
        filenameLabel.isHidden = false
    }
}




