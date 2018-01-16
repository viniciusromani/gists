//
//  GistCollectionViewCell.swift
//  GithubGists
//
//  Created by Vinicius Romani on 16/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import UIKit

class GistCollectionViewCell: UICollectionViewCell {
    static let nibName = "GistCollectionViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    func configure(with viewModel: GistViewModel) {
        nameLabel.text = viewModel.name
//        userImageView
        userLabel.text = viewModel.userName
    }
}
