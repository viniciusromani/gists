//
//  UserEntityTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 14/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import XCTest

class UserEntityTest: XCTestCase {
    
    // MARK: Variables
    
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
    
    func testNoAttributesValidJSON() {
        localJSON = "withid_withoutatt"
        
        // It is a valid JSON because it has id
        XCTAssertNoThrow(try JSONDecoder().decode(UserEntity.self, from: jsonData))
        let userEntity = try? JSONDecoder().decode(UserEntity.self, from: jsonData)
        XCTAssertNotNil(userEntity)
        XCTAssertNotNil(userEntity?.id)
        XCTAssertTrue(!userEntity!.id.isEmpty)
        
        // Parameters should be all null
        XCTAssertNil(userEntity?.userName)
        XCTAssertNil(userEntity?.userGithubURL)
        XCTAssertNil(userEntity?.avatarURL)
    }
    
    func testNoIdAttribute() {
        localJSON = "withoutid_withatt"
        
        // It is a valid JSON because it has id
        XCTAssertThrowsError(try JSONDecoder().decode(UserEntity.self, from: jsonData))
        let userEntity = try? JSONDecoder().decode(UserEntity.self, from: jsonData)
        XCTAssertNil(userEntity)
        XCTAssertNil(userEntity?.id)
        
        // Parameters should be all null
        XCTAssertNil(userEntity?.userName)
        XCTAssertNil(userEntity?.userGithubURL)
        XCTAssertNil(userEntity?.avatarURL)
    }
    
    func testInvalidIdValueJSON() {
        localJSON = "withwrongid_withatt"
        
        // It is a valid JSON because it has id
        XCTAssertThrowsError(try JSONDecoder().decode(UserEntity.self, from: jsonData))
        let userEntity = try? JSONDecoder().decode(UserEntity.self, from: jsonData)
        XCTAssertNil(userEntity)
        XCTAssertNil(userEntity?.id)
        
        // Parameters should be all null
        XCTAssertNil(userEntity?.userName)
        XCTAssertNil(userEntity?.userGithubURL)
        XCTAssertNil(userEntity?.avatarURL)
    }
}

// MARK: - Testable Entity Protocol

extension UserEntityTest: TestableEntity {
    
    // MARK: - Protocol variable
    
    var localJSON: String {
        get { return _localJSON }
        set { _localJSON = newValue }
    }
    
    // MARK: - Protocol method
    
    func testSuccessFulInit() {
        localJSON = "user_entity"
        XCTAssertNoThrow(try JSONDecoder().decode(UserEntity.self, from: jsonData))
        let userEntity = try? JSONDecoder().decode(UserEntity.self, from: jsonData)
        XCTAssertNotNil(userEntity)
        XCTAssertNotNil(userEntity?.id)
        XCTAssertTrue(!userEntity!.id.isEmpty)
        
        // Testing if it has all parameters set
        XCTAssertNotNil(userEntity?.userName)
        XCTAssertNotNil(userEntity?.userGithubURL)
        XCTAssertNotNil(userEntity?.avatarURL)
    }
}
