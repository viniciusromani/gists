//
//  TestViewController.swift
//  GithubGists
//
//  Created by Vinicius Romani on 04/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Moya

class TestViewController: UIViewController {
    
    let dataSource = GistRestDataSource()
    var repository: GistRespository!
    var useCase: RetrievePublicGistsUseCase!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repository = GistRespository(restApi: dataSource)
        useCase = RetrievePublicGistsUseCase(controller: repository)
        
        useCase.retrievePublicGists().subscribe(onNext: { gists in
            
            
            print("success")
        }, onError: { error in
            
            print("error")
        }).disposed(by: disposeBag)
    }
    
}
