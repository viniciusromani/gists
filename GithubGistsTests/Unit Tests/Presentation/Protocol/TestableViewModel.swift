//
//  TestableViewModel.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 29/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import XCTest

protocol TestableViewModel where Self: XCTestCase  {
    associatedtype Model: MappableModel
    var model: Model? { get set }
    func testSuccessFullMapping()
}
