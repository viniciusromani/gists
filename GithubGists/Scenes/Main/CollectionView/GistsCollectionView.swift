//
//  GistsCollectionView.swift
//  TwitchGames
//
//  Created by Vinicius Romani on 30/11/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import UIKit

protocol GistsCollectionViewDelegate {
    func configure(gistCollection collectionView: GistsCollectionView)
    func didSelect(collectionView collection: UICollectionView, at indexPath: IndexPath)
}

class GistsCollectionView: UICollectionView {
    
    let cellIdentifier = Constants.CellIdentifier.GistCollectionView
    
    var displayedDataSource: [DisplayedGistCell] = [] {
        didSet {
            reloadData()
        }
    }
    
    var customDelegate: GistsCollectionViewDelegate?
}

extension GistsCollectionView: UICollectionViewDelegate { }

extension GistsCollectionView: UICollectionViewDataSource {
    
    override var numberOfSections: Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
            as? GistCollectionViewCell else { return UICollectionViewCell() }
        
        let displayedData = displayedDataSource[indexPath.row]
        cell.configure(with: displayedData)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        customDelegate?.didSelect(collectionView: collectionView, at: indexPath)
    }
}

extension GistsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = Constants.CellSize.GistCollectionCellHeight
        let halfOfWidth = collectionView.bounds.width / 2
        let cellSpacing = (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 5.0
        let size = CGSize(width: halfOfWidth - cellSpacing, height: cellHeight)
        return size
    }
}


