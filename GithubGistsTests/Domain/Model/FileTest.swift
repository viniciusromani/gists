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
    
    // MARK: - Variables
    
    private var filename = "ring.erl"
    private var bodyJSON: JSON = []
    var json: JSON = []
    
    // MARK: - XCTestCase Cycle
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        bodyJSON = ["filename": filename,
                    "size": 932,
                    "raw_url": "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl",
                    "language": "Erlang"]
        json = [filename: bodyJSON]
        
        // Mandatory test
        testHasValidKey()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        bodyJSON = []
        json = []
    }
    
    // MARK: - Tests
    
    func testHasValidKey() {
        XCTAssertNotNil(json.dictionaryValue.keys.first)
    }
    
    func testSuccessfulInit() {
        let file = File(with: json[json.dictionaryValue.keys.first!])
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
        json.dictionaryObject?.removeValue(forKey: filename)
        json[""] = bodyJSON
        let file = File(with: json)
        XCTAssertNil(file)
    }
    
    func testWrongKeysInit() {
        var testFile: File?
        
        // Size Key
        testFile = wrongSizeKey()
        XCTAssertNotNil(testFile)
        XCTAssertTrue(testFile?.size == nil)
        setUp()
        
        // Language Key
        testFile = wrongLanguageKey()
        XCTAssertNotNil(testFile)
        XCTAssertTrue(testFile?.language == nil)
        setUp()
        
        // URL Key
        testFile = wrongURLKey()
        XCTAssertNotNil(testFile)
        XCTAssertTrue(testFile?.url == nil)
    }
    
    func testWrongValuesInit() {
        var testFile: File?
        
        // Size Key
        testFile = wrongSizeValue()
        XCTAssertNotNil(testFile)
        XCTAssertTrue(testFile?.size == nil)
        setUp()
        
        // Language Key
        testFile = wrongLanguageValue()
        XCTAssertNotNil(testFile)
        XCTAssertTrue(testFile?.language == nil)
        setUp()
        
        // URL Key
        testFile = wrongURLValue()
        XCTAssertNotNil(testFile)
        XCTAssertTrue(testFile?.url == nil)
    }
}

// MARK: - Helpers

extension FileTest {
    
    // MARK: - Wrong Keys
    
    private func wrongSizeKey() -> File? {
        bodyJSON.dictionaryObject?.removeValue(forKey: "size")
        bodyJSON["SIZE"] = 932
        json[filename] = bodyJSON
        let file = File(with: json[json.dictionaryValue.keys.first!])
        return file
    }
    
    private func wrongLanguageKey() -> File? {
        bodyJSON.dictionaryObject?.removeValue(forKey: "language")
        bodyJSON["lan"] = "Erlang"
        json[filename] = bodyJSON
        let file = File(with: json[json.dictionaryValue.keys.first!])
        return file
    }
    
    private func wrongURLKey() -> File? {
        bodyJSON.dictionaryObject?.removeValue(forKey: "raw_url")
        bodyJSON["rawURL"] = "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl"
        json[filename] = bodyJSON
        let file = File(with: json[json.dictionaryValue.keys.first!])
        return file
    }
    
    // MARK: - Wrong Values
    
    private func wrongSizeValue() -> File? {
        bodyJSON["size"] = "932"
        json[filename] = bodyJSON
        let file = File(with: json[json.dictionaryValue.keys.first!])
        return file
    }
    
    private func wrongLanguageValue() -> File? {
        bodyJSON["language"] = true
        json[filename] = bodyJSON
        let file = File(with: json[json.dictionaryValue.keys.first!])
        return file
    }
    
    private func wrongURLValue() -> File? {
        bodyJSON["raw_url"] = 562
        json[filename] = bodyJSON
        let file = File(with: json[json.dictionaryValue.keys.first!])
        return file
    }
}
