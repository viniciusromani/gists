//
//  GistCollectionViewCell.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 30/11/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import UIKit

class GistCollectionViewCell: UICollectionViewCell {
    
    static var nibName = "GistCollectionViewCell"
    
    @IBOutlet weak var gistNameLabel: UILabel!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    
    func configure(with displayedCell: DisplayedGistCell) {
        gistNameLabel.text = displayedCell.fileName
        ownerNameLabel.text = displayedCell.userName
    }
}
