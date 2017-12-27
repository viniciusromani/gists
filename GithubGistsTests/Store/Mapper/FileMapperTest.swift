//
//  FileMapperTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 26/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import XCTest

class FileMapperTest: XCTestCase {
    
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
    
    /*
     *  The goal is testing the mapper init method for an entity
     *  with all attributes
     */
    func testValidValuesMapper() {
        let fileEntity = FileEntity(name: "ring.erlang",
                                    size: 932.0,
                                    language: "Erlang",
                                    url: URL(string: "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl"))
        let file = File(mapping: fileEntity)
        
        XCTAssert(file.name == fileEntity.name)
        XCTAssert(file.size == fileEntity.size)
        XCTAssertNotNil(file.language)
        XCTAssert(file.language == fileEntity.language)
        XCTAssertNotNil(file.url)
        XCTAssert(file.url == fileEntity.url)
    }
    
    /*
     *  The goal is testing the mapper init method for an entity
     *  without all attributes - with some nils in it
     */
    func testInvalidLanguage() {
        let fileEntity = FileEntity(name: "ring.erlang",
                                    size: 932.0,
                                    language: nil,
                                    url: URL(string: "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl"))
        let file = File(mapping: fileEntity)
        
        XCTAssert(file.name == fileEntity.name)
        XCTAssert(file.size == fileEntity.size)
        XCTAssertNil(file.language)
        XCTAssert(file.language == fileEntity.language)
        XCTAssertNotNil(file.url)
        XCTAssert(file.url == fileEntity.url)
    }
    
}
