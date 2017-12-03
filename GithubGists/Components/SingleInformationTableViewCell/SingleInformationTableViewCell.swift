//
//  SingleInformationTableViewCell.swift
//  GithubGists
//
//  Created by Vinicius Romani on 03/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import UIKit

struct DisplayedSingleInformationCell {
    let description: String
    let content: String?
}

class SingleInformationTableViewCell: UITableViewCell {
    
    static var nibName = "SingleInformationTableViewCell"
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    func configure(with displayedCell: DisplayedSingleInformationCell) {
        descriptionLabel.text = displayedCell.description
        contentLabel.text = displayedCell.content
    }
}
