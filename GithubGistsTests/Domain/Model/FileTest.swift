//
//  FileTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 18/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import XCTest
import SwiftyJSON

class FileTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSuccessfulInit() {
        let successJSON: JSON = ["size": 932,
                                 "raw_url": "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl",
                                 "language": "Erlang"]
        let finalJSON: JSON = ["ring.erl": successJSON]
        
        let file = File(with: finalJSON)
        XCTAssertNotNil(file)
        XCTAssertNotNil(file?.name)
    }
    
    func testNilJSONInit() {
        let errorJSON = JSON.null
        let file = File(with: errorJSON)
        XCTAssertNil(file)
    }
    
    func testEmptyJSONInit() {
        let errorJSON: JSON = []
        let file = File(with: errorJSON)
        XCTAssertNil(file)
    }
    
    func testEmptyNameJSONInit() {
        let errorJSON: JSON = ["size": 932,
                               "raw_url": "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl",
                               "language": "Erlang"]
        let finalJSON: JSON = ["": errorJSON]
        let file = File(with: finalJSON)
        XCTAssertNil(file)
    }
    
    func testWrongKeysInit() {
        var testFile: File?
        
        // Size Key
        testFile = wrongSizeKey()
        XCTAssertNotNil(testFile)
        XCTAssertTrue(testFile?.size == nil)
        
        // Language Key
        testFile = wrongLanguageKey()
        XCTAssertNotNil(testFile)
        XCTAssertTrue(testFile?.language == nil)
        
        // URL Key
        testFile = wrongURLKey()
        XCTAssertNotNil(testFile)
        XCTAssertTrue(testFile?.url == nil)
    }
}

// MARK: - Helpers

extension FileTest {
    
    private func wrongSizeKey() -> File? {
        let errorJSON: JSON = ["SIZE": 932,
                               "raw_url": "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl",
                               "language": "Erlang"]
        let finalJSON: JSON = ["ring.erl": errorJSON]
        let file = File(with: finalJSON)
        return file
    }
    
    private func wrongLanguageKey() -> File? {
        let errorJSON: JSON = ["size": 932,
                               "raw_url": "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl",
                               "lan": "Erlang"]
        let finalJSON: JSON = ["ring.erl": errorJSON]
        let file = File(with: finalJSON)
        return file
    }
    
    private func wrongURLKey() -> File? {
        let errorJSON: JSON = ["size": 932,
                               "rawURL": "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl",
                               "language": "Erlang"]
        let finalJSON: JSON = ["ring.erl": errorJSON]
        let file = File(with: finalJSON)
        return file
    }
}
