//
//  GistDetailViewController.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 30/11/17.
//  Copyright (c) 2017 Vinicius Romani. All rights reserved.
//

import UIKit

protocol GistDetailTableViewControllerInput {
    func displayGistSuccess(_ viewModel: GistDetail.FetchGist.ViewModel.Success)
    func displayGistError(_ viewModel: GistDetail.FetchGist.ViewModel.Error)
}

protocol GistDetailTableViewControllerOutput {
    var selectedGistId: String? { get set }
    
    func fetchGist(_ request: GistDetail.FetchGist.Request)
}

class GistDetailTableViewController: UITableViewController {
    var output: GistDetailTableViewControllerOutput!
    var router: GistDetailRouter!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var urlButton: UIButton!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerURLButton: UIButton!
    
    // MARK: - Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        GistDetailConfigurator.sharedInstance.configure(tableViewController: self)
    }

    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchSelectedGist()
    }
}

// MARK: - Display logic

extension GistDetailTableViewController: GistDetailTableViewControllerInput {
    
    func displayGistSuccess(_ viewModel: GistDetail.FetchGist.ViewModel.Success) {
        let displayedGist = viewModel.displayedGistDetail
        descriptionLabel.text = displayedGist.description
        urlButton.titleLabel?.text = displayedGist.gistURL
        languageLabel.text = displayedGist.language
        forksLabel.text = displayedGist.forksCounter
        ownerNameLabel.text = displayedGist.ownerName
        ownerURLButton.titleLabel?.text = displayedGist.ownerGithubURL
    }
    
    func displayGistError(_ viewModel: GistDetail.FetchGist.ViewModel.Error) {
        
    }
}

// MARK: - Helpers

extension GistDetailTableViewController {
    private func fetchSelectedGist() {
        let request = GistDetail.FetchGist.Request()
        output.fetchGist(request)
    }
}




