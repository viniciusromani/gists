//
//  TestableModel.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 25/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import XCTest

protocol TestableModel where Self: XCTestCase  {
    associatedtype Entity: MappableEntity
    var entity: Entity? { get set }
    func testSuccessFullMapping()
}
