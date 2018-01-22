//
//  PublicGistsCollectionView.swift
//  GithubGists
//
//  Created by Vinicius Romani on 16/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import UIKit

class PublicGistsCollectionView: UICollectionView {
    
    let cellIdentifier = R.reuseIdentifier.gistCollectionViewCellIdentifier
    
    var displayedGists: [GistViewModel] = [] {
        didSet {
            reloadData()
        }
    }
}

extension PublicGistsCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selectionou")
    }
}

extension PublicGistsCollectionView: UICollectionViewDataSource {
    
    override var numberOfSections: Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedGists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let gistCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) else {
            return UICollectionViewCell()
        }
        
        let gistViewModel = displayedGists[indexPath.row]
        gistCell.configure(with: gistViewModel)
        
        return gistCell
    }
}

extension PublicGistsCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = CGFloat(165.0)
        let cellSpacing = (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 5.0
        let halfOfWidth = (collectionView.bounds.width - (cellSpacing * 2)) / 2
        let size = CGSize(width: halfOfWidth - cellSpacing, height: cellHeight)
        return size
    }
}


