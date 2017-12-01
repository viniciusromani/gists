//
//  BaseViewController.swift
//  GithubGists
//
//  Created by Vinicius Romani on 01/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    var activityIndicatorContainerView : UIView!
    
    func showActivityIndicator() {
        if activityIndicatorContainerView == nil {
            activityIndicatorContainerView = UIView()
            view.addSubview(activityIndicatorContainerView)
            activityIndicatorContainerView.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
            
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
            activityIndicator.startAnimating()
            activityIndicatorContainerView.addSubview(activityIndicator)
            
            activityIndicator.snp.makeConstraints { (make) in
                make.center.equalTo(activityIndicatorContainerView)
            }
        }
        
        activityIndicatorContainerView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        activityIndicatorContainerView.isHidden = false
    }
    
    func hideActivityIndicator() {
        guard activityIndicatorContainerView != nil else {
            return
        }
        activityIndicatorContainerView.isHidden = true
    }
    
}
