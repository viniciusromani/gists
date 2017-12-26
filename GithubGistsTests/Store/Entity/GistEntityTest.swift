//
//  GistEntityTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 18/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import XCTest
import SwiftyJSON

class GistEntityTest: XCTestCase {
    
    // MARK: - Variables
    
    private var _localJSON: String = ""
    
    // MARK: - XCTestCase Cycle
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Tests
    
}

// MARK: - Testable Entity Protocol

extension GistEntityTest: TestableEntity {
    
    // MARK: - Protocol variable
    
    var localJSON: String {
        get { return _localJSON }
        set { _localJSON = newValue }
    }
    
    // MARK: - Protocol method
    
    func testSuccessFulInit() {
        localJSON = "gist_entity"
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        XCTAssertNoThrow(try jsonDecoder.decode(GistEntity.self, from: jsonData))
        let gistEntity = try? jsonDecoder.decode(GistEntity.self, from: jsonData)
        XCTAssertNotNil(gistEntity)
        XCTAssertNotNil(gistEntity?.id)
        XCTAssertTrue(gistEntity!.id.count > 0)
        
        // Testing if it has all parameters set
        XCTAssertNotNil(gistEntity?.description)
        XCTAssertNotNil(gistEntity?.apiURL)
        XCTAssertNotNil(gistEntity?.htmlURL)
        XCTAssertNotNil(gistEntity?.files)
        XCTAssertNotNil(gistEntity?.owner)
        XCTAssertNotNil(gistEntity?.isPublic)
        XCTAssertNotNil(gistEntity?.createdAt)
    }
}




