//
//  PublicGistsCollectionView.swift
//  GithubGists
//
//  Created by Vinicius Romani on 16/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import UIKit

protocol PublicGistsAdapterViewProtocol {
    func didSelect(gist gistViewModel: GistViewModel)
}

final class PublicGistsAdapter: NSObject {
    var dataSet: [GistViewModel] = []
    var collectionView: UICollectionView
    var viewDelegate: PublicGistsAdapterViewProtocol?
    
    init(collectionView: UICollectionView, viewDelegate: PublicGistsAdapterViewProtocol?) {
        self.collectionView = collectionView
        self.viewDelegate = viewDelegate
        super.init()
        
        setup(collectionView: collectionView)
    }
}

extension PublicGistsAdapter: CollectionViewProtocol {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = R.reuseIdentifier.gistCollectionViewCellIdentifier
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: model(for: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewDelegate?.didSelect(gist: model(for: indexPath))
    }
}

extension PublicGistsAdapter: CollectionViewLayoutProtocol {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = CGFloat(165.0)
        let cellSpacing = (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 5.0
        let halfOfWidth = (collectionView.bounds.width - (cellSpacing * 2)) / 2
        let size = CGSize(width: halfOfWidth - cellSpacing, height: cellHeight)
        return size
    }
}

extension PublicGistsAdapter: CollectionViewAdapter {
    typealias ModelType = GistViewModel
    
    func registerCell() {
        collectionView.register(R.nib.gistCollectionViewCell)
    }
}

