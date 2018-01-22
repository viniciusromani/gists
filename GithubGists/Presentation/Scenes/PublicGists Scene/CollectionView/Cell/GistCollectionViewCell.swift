//
//  GistCollectionViewCell.swift
//  GithubGists
//
//  Created by Vinicius Romani on 16/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class GistCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    func configure(with viewModel: GistViewModel) {
        nameLabel.text = viewModel.name
        userImageView.kf.setImage(with: viewModel.userImageURL, placeholder: R.image.ic_person())
        userLabel.text = viewModel.userName ?? "-"
    }
}
