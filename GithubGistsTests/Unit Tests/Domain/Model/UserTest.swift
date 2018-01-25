//
//  UserTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 25/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import XCTest

/*
 * This class is going to test User and
 * its respective mapper described in User+Mappable.
 */

class UserTest: XCTestCase {
    
    // MARK: Variables
    
    var entity: UserEntity?
    
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
     * Invalid ID testing, it should not parse and throw an error.
     */
    func testInvalidId() {
        entity = UserEntity(id: -1,
                            userName: "VictoriaDem",
                            userGithubURL: "https://github.com/VictoriaDem",
                            avatarURL: "https://avatars0.githubusercontent.com/u/34760928?v=4")
        
        XCTAssertThrowsError(try User(mapping: entity))
    }
}

// MARK: - TestableModel Protocol Conformance

extension UserTest: TestableModel {
    
    // MARK: - Typealias
    
    typealias Entity = UserEntity
    
    // MARK: - Successfull test
    
    /*
     * This method is going to test a successfull mapping
     * but at the same time it will test URL parsing using
     * userGithubURL for a valid URL and avatarURL for
     * a invalid one.
     */
    func testSuccessFullMapping() {
        entity = UserEntity(id: 34760928,
                            userName: "VictoriaDem",
                            userGithubURL: "https://github.com/VictoriaDem",
                            avatarURL: nil)
        var user: User?
        
        do {
            user = try User(mapping: entity)
            
            XCTAssertNotNil(user?.id)
            XCTAssert(Int(user?.id ?? "0") == entity?.id)
            
            XCTAssertNotNil(user?.userName)
            XCTAssert(user?.userName == entity?.userName)
            XCTAssertNotNil(user?.userGithubURL)
            let entityGithubURL = URL(string: entity?.userGithubURL ?? "")
            XCTAssert(user?.userGithubURL == entityGithubURL)
            XCTAssertNil(user?.avatarURL)
        } catch {
            XCTFail()
        }
    }
}

