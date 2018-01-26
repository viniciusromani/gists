//
//  Date+Utils.swift
//  GithubGists
//
//  Created by Vinicius Romani on 26/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation

// MARK: - Date Extension

extension Date {
    
    // MARK: - init utils
    
    init?(usingIsoFormatterFor string: String?) {
        guard let str = string else { return nil }
        let isoFormatter = DateFormatter.isoFormatter
        guard let date = isoFormatter.date(from: str) else { return nil }
        self = date
    }
    
    // MARK: - string utils
    
    var stringUsingIsoFormatter: String {
        let isoFormatter = DateFormatter.isoFormatter
        return isoFormatter.string(from: self)
    }
}

// MARK: - DateFormatter Extension

fileprivate extension DateFormatter {
    
    class var base: DateFormatter {
        let formatter = DateFormatter()
        return formatter
    }
    
    class var isoFormatter: ISO8601DateFormatter {
        let isoFormatter = ISO8601DateFormatter()
        return isoFormatter
    }
}
