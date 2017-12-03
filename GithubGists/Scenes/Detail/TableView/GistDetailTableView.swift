//
//  GistDetailTableView.swift
//  GithubGists
//
//  Created by Vinicius Romani on 03/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import UIKit

protocol GistDetailTableViewDelegate {
    func configure(gistTableView tableView: GistDetailTableView)
}

class GistDetailTableView: UITableView {
    
    let cellIdentifier = Constants.CellIdentifier.GistTableView
    
    var displayedDataSource: [DisplayedSingleInformationCell] = [] {
        didSet {
            reloadData()
        }
    }
    
    var customDelegate: GistDetailTableViewDelegate?
}

extension GistDetailTableView: UITableViewDelegate { }

extension GistDetailTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as? SingleInformationTableViewCell else { return UITableViewCell() }
        
        let displayedData = displayedDataSource[indexPath.row]
        cell.configure(with: displayedData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}


