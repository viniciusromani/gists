//
//  GistDetailViewController.swift
//  GithubGists
//
//  Created by Vinicius Romani on 05/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import UIKit

// MARK: - View Protocol

protocol GistDetailsViewProtocol: class {
    var presenter: GistDetailsPresenterProtocol! { get set }
    var router: GistDetailsRouterProtocol! { get set }
    
    func display(_ viewModel: GistDetailsViewModel)
}

// MARK: - ViewController

class GistDetailsViewController: UIViewController {
    
    var presenter: GistDetailsPresenterProtocol!
    var router: GistDetailsRouterProtocol!
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var gistURLLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var ownerGithubLabel: UILabel!
    
    // MARK: - ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.retrieveSelectedGist()
    }
}

// MARK: - Display logic

extension GistDetailsViewController: GistDetailsViewProtocol {
    
    func display(_ viewModel: GistDetailsViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        gistURLLabel.text = viewModel.url
        languageLabel.text = viewModel.language
        forksLabel.text = viewModel.forks
        ownerLabel.text = viewModel.ownerName
        ownerGithubLabel.text = viewModel.ownerGithubURL
    }
}






