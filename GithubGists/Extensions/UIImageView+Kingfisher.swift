//
//  UIImageView+Kingfisher.swift
//  GithubGists
//
//  Created by Vinicius Romani on 01/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    public func setImageWithURL(_ url: Foundation.URL?,
                                placeholderImage: Image? = nil,
                                progressBlock: DownloadProgressBlock? = nil,
                                completionHandler: CompletionHandler? = nil) {
        if let urlString = url?.absoluteString {
            //Loading indicator
            kf.indicatorType = .activity
            //search for image in cache, if doesn't exist download it
            let kfUrl = URL(string: urlString)
            kf.setImage(with: kfUrl, completionHandler: { (image, error, _, _) in
                if error != nil {
                    self.image = placeholderImage
                }
            })
        } else {
            image = placeholderImage
        }
    }
}
