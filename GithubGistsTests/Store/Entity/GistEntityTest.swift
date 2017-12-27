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
    private var jsonDecoder = JSONDecoder()
    
    // MARK: - XCTestCase Cycle
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        jsonDecoder.dateDecodingStrategy = .iso8601
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testNoIdAttribute() {
        localJSON = "withoutid_withatt"
        
        XCTAssertThrowsError(try jsonDecoder.decode(GistEntity.self, from: jsonData))
        let gistEntity = try? jsonDecoder.decode(GistEntity.self, from: jsonData)
        XCTAssertNil(gistEntity)
        XCTAssertNil(gistEntity?.id)
        
        // Parameters should be all null
        XCTAssertNil(gistEntity?.description)
        XCTAssertNil(gistEntity?.apiURL)
        XCTAssertNil(gistEntity?.htmlURL)
        XCTAssertNil(gistEntity?.files)
        XCTAssertNil(gistEntity?.owner)
        XCTAssertNil(gistEntity?.isPublic)
        XCTAssertNil(gistEntity?.createdAt)
    }
    
    /*
     *  Parameters we want to cover in this test:
     *  - description should be null
     *  - apiURL should be null
     *  - htmlURL should be null
     *  - files should not have objects in it
     *  - owner should exist
     */
    func testZeroFilesOneOwnerJSON() {
        localJSON = "withid_withoutfile_withowner"
        
        XCTAssertNoThrow(try jsonDecoder.decode(GistEntity.self, from: jsonData))
        let gistEntity = try? jsonDecoder.decode(GistEntity.self, from: jsonData)
        XCTAssertNotNil(gistEntity)
        XCTAssertNotNil(gistEntity?.id)
        
        // Testing parameters
        XCTAssertNil(gistEntity?.description)
        XCTAssertNil(gistEntity?.apiURL)
        XCTAssertNil(gistEntity?.htmlURL)
        
        XCTAssertNotNil(gistEntity?.files)
        XCTAssertTrue(gistEntity!.files.count == 0)
        
        XCTAssertNotNil(gistEntity?.owner)
    }
    
    /*
     *  Parameters we want to cover in this test:
     *  - files should have only one object
     *  - owner should be null
     *  - isPublic should be true
     */
    func testOneFileZeroOnwersJSON() {
        localJSON = "withid_withfile_withoutowner"
        
        XCTAssertNoThrow(try jsonDecoder.decode(GistEntity.self, from: jsonData))
        let gistEntity = try? jsonDecoder.decode(GistEntity.self, from: jsonData)
        XCTAssertNotNil(gistEntity)
        XCTAssertNotNil(gistEntity?.id)
        
        // Testing parameters
        XCTAssertNotNil(gistEntity?.files)
        XCTAssertTrue(gistEntity!.files.count == 1)
        
        XCTAssertNil(gistEntity?.owner)
        
        XCTAssertNotNil(gistEntity?.isPublic)
        XCTAssertTrue(gistEntity!.isPublic!)
    }
    
    /*
     *  Parameters we want to cover in this test:
     *  - files should have two objects
     *  - owner should exist
     *  - isPublic should be false
     *  - createdAt should exist
     */
    func testTwoFilesZeroOnwersAndValidDateJSON() {
        localJSON = "withid_withfiles_withowner"
        
        XCTAssertNoThrow(try jsonDecoder.decode(GistEntity.self, from: jsonData))
        let gistEntity = try? jsonDecoder.decode(GistEntity.self, from: jsonData)
        XCTAssertNotNil(gistEntity)
        XCTAssertNotNil(gistEntity?.id)
        
        // Testing parameters
        XCTAssertNotNil(gistEntity?.files)
        XCTAssertTrue(gistEntity!.files.count == 2)
        
        XCTAssertNotNil(gistEntity?.owner)
        
        XCTAssertNotNil(gistEntity?.isPublic)
        XCTAssertFalse(gistEntity!.isPublic!)
        
        XCTAssertNotNil(gistEntity?.createdAt)
    }
    
    /*
     *  Parameters we want to cover in this test:
     *  - description should exist
     *  - apiURL should exist
     *  - htmlURL should exist
     *  - createdAt should not exist
     */
    func testInvalidDateJSON() {
        localJSON = "withid_withfile_withinvaliddate"
        
        XCTAssertNoThrow(try jsonDecoder.decode(GistEntity.self, from: jsonData))
        let gistEntity = try? jsonDecoder.decode(GistEntity.self, from: jsonData)
        XCTAssertNotNil(gistEntity)
        XCTAssertNotNil(gistEntity?.id)
        
        // Testing parameters
        XCTAssertNotNil(gistEntity?.description)
        
        XCTAssertNotNil(gistEntity?.apiURL)
        
        XCTAssertNotNil(gistEntity?.htmlURL)
        
        XCTAssertNil(gistEntity?.createdAt)
    }
    
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




