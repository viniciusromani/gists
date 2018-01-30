//
//  TestableMappingIntegration.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 30/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import Foundation
import XCTest
import Nimble

protocol TestableMappingIntegration where Self: XCTestCase {
    var localJSON: String { get set }
    var jsonData: Data { get }
    
    associatedtype Entity: MappableEntity
    var entity: Entity? { get set }
    associatedtype Model: MappableModel
    var model: Model? { get set }
    associatedtype ViewModel: MappableViewModel
    var viewModel: ViewModel? { get set }
    
    func testSuccessfulMapping()
    func testStoreError()
    func testDomainError()
}

extension TestableMappingIntegration {
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
