//
//  GistDetailPresenter.swift
//  GithubGists
//
//  Created by Vinicius Romani on 05/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Presenter Protocol

protocol GistDetailsPresenterProtocol: class {
    weak var view: GistDetailsViewProtocol! { get set }
    var retrieveGistWithIdUseCase: RetrieveGistWithIdUseCase! { get set }
    var selectedGistId: String! { get set }
    
    func retrieveSelectedGist()
}

// MARK: - Presenter Implementation

class GistDetailsPresenter: GistDetailsPresenterProtocol {
    
    // MARK: - View
    
    var view: GistDetailsViewProtocol!
    
    // MARK: - Use Case
    
    var retrieveGistWithIdUseCase: RetrieveGistWithIdUseCase!
    
    // MARK: - Variables
    
    var selectedGistId: String!
    let disposeBag = DisposeBag()
    
    // MARK: - Features
    
    func retrieveSelectedGist() {
        
        retrieveGistWithIdUseCase.retrieveGist(withId: selectedGistId).subscribe(onNext: { [weak self] gist in
            guard let weakSelf = self else { return }
            let gistDetailsViewModel = GistDetailsViewModel(mapping: gist)
            weakSelf.view.display(gistDetailsViewModel)
            
        }, onError: { [weak self] error in
            guard let weakSelf = self else { return }
            
            print("errouu")
        }).disposed(by: disposeBag)
    }
}
