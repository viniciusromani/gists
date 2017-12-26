//
//  FileEntityTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 18/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import XCTest
import SwiftyJSON

class FileEntityTest: XCTestCase {
    
    // MARK: - Variables
    
    private var _localJSON: String = ""
    private var jsonDecoder = JSONDecoder()
    
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
    
    func testOnlyInvalidSizeAttributeValidJSON() {
        localJSON = "withfilename_withoutatt"
        
        // It is a valid JSON because it has id
        XCTAssertNoThrow(try jsonDecoder.decode(FileEntity.self, from: jsonData))
        let fileEntity = try? jsonDecoder.decode(FileEntity.self, from: jsonData)
        XCTAssertNotNil(fileEntity)
        XCTAssertNotNil(fileEntity?.name)
        XCTAssertTrue(!fileEntity!.name.isEmpty)
        
        // Parameters should be all null
        XCTAssertNotNil(fileEntity?.size)
        XCTAssertNil(fileEntity?.language)
        XCTAssertNil(fileEntity?.url)
    }
    
    func testNoFilenameAttribute() {
        localJSON = "withoutfilename_withatt"
        
        // It is a valid JSON because it has id
        XCTAssertThrowsError(try jsonDecoder.decode(FileEntity.self, from: jsonData))
        let fileEntity = try? jsonDecoder.decode(FileEntity.self, from: jsonData)
        XCTAssertNil(fileEntity)
        XCTAssertNil(fileEntity?.name)
        
        // Parameters should be all null
        XCTAssertNil(fileEntity?.size)
        XCTAssertNil(fileEntity?.language)
        XCTAssertNil(fileEntity?.url)
    }
    
    func testInvalidFilenameValueJSON() {
        localJSON = "withwrongfilename_withatt"
        
        // It is a valid JSON because it has id
        XCTAssertThrowsError(try jsonDecoder.decode(FileEntity.self, from: jsonData))
        let fileEntity = try? jsonDecoder.decode(FileEntity.self, from: jsonData)
        XCTAssertNil(fileEntity)
        XCTAssertNil(fileEntity?.name)
        
        // Parameters should be all null
        XCTAssertNil(fileEntity?.size)
        XCTAssertNil(fileEntity?.language)
        XCTAssertNil(fileEntity?.url)
    }
}

// MARK: - Testable Entity Protocol

extension FileEntityTest: TestableEntity {
    
    // MARK: - Protocol variable
    
    var localJSON: String {
        get { return _localJSON }
        set { _localJSON = newValue }
    }
    
    // MARK: - Protocol method
    
    func testSuccessFulInit() {
        localJSON = "file_entity"
        XCTAssertNoThrow(try jsonDecoder.decode(FileEntity.self, from: jsonData))
        let fileEntity = try? jsonDecoder.decode(FileEntity.self, from: jsonData)
        XCTAssertNotNil(fileEntity)
        XCTAssertNotNil(fileEntity?.name)
        XCTAssertTrue(!fileEntity!.name.isEmpty)
        
        // Testing if it has all parameters set
        XCTAssertNotNil(fileEntity?.size)
        XCTAssertNotNil(fileEntity?.language)
        XCTAssertNotNil(fileEntity?.url)
    }
}
