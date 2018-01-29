//
//  TestableEntity.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 20/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import XCTest
import Nimble

protocol TestableEntity where Self: XCTestCase {
    var localJSON: String { get set }
    var jsonData: Data { get }
    
    func testSuccessFulInit()
}

extension TestableEntity {
    var jsonData: Data {
        get {
            guard let path = Bundle(for: type(of: self)).url(forResource: localJSON, withExtension: "json") else {
                fail("\(localJSON).json not found")
                fatalError("\(localJSON).json not found")
            }
            
            do {
                return try Data(contentsOf: path)
            } catch {
                fail("\(localJSON).json not found")
                fatalError("\(localJSON).json could not be opened")
            }
        }
    }
}

