//
//  PublicGistsPresenter.swift
//  GithubGists
//
//  Created by Vinicius Romani on 16/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import RxSwift

protocol PublicGistsPresenterProtocol: class {
    weak var view: PubicGistsViewProtocol! { get set }
    var retrievePublicGistsUseCase: RetrievePublicGistsUseCase! { get set }
    
    func retrievePublicGists()
}

class PublicGistsPresenter: PublicGistsPresenterProtocol {
    
    // MARK: - View
    var view: PubicGistsViewProtocol!
    
    // MARK: - Use Case
    var retrievePublicGistsUseCase: RetrievePublicGistsUseCase!
    
    // MARK: - Variables
    
    let disposeBag = DisposeBag()
    
    // MARK: - Features
    
    func retrievePublicGists() {
        
        retrievePublicGistsUseCase.retrievePublicGists().subscribe(onNext: { [weak self] gists in
            
            guard let weakSelf = self else { return }
            let gistsViewModel = GistViewModel.array(mapping: gists)
            let publicGists = PublicGistsViewModel(gists: gistsViewModel)
            weakSelf.view.display(publicGists)
            
        }, onError: { error in
            
            print("error")
        }).disposed(by: disposeBag)
    }
}
