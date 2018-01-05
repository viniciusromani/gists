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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let disposeBag = DisposeBag()
        let repository = GistRespository(restApi: GistRestDataSource())
        
        let useCase = RetrieveGistWithIdUseCase(controller: repository)
        useCase.retrieveGist(withId: "1dbdf925bf646bf868f02d9b18bce1b7").subscribe(onNext: { gist in
            
            print("success")
        }, onError: { error in
            
            print("error")
        }).disposed(by: disposeBag)
    }
    
}
