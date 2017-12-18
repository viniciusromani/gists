//
//  UserTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 14/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import XCTest
import SwiftyJSON

class UserTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSuccessfulInit() {
        let successJSON: JSON = ["id": 148100,
                                 "login": "invalid-email-address",
                                 "html_url": "https://github.com/invalid-email-address",
                                 "avatar_url": "https://avatars0.githubusercontent.com/u/148100?v=4"]
        
        let user = User(with: successJSON)
        XCTAssertNotNil(user)
        XCTAssertNotNil(user?.id)
    }
    
    func testNilJSONInit() {
        let errorJSON = JSON.null
        let user = User(with: errorJSON)
        XCTAssertNil(user)
    }
    
    func testEmptyJSONInit() {
        let errorJSON: JSON = []
        let user = User(with: errorJSON)
        XCTAssertNil(user)
    }
    
    func testIdZeroJSONInit() {
        let successJSON: JSON = ["id": 0,
                                 "login": "invalid-email-address",
                                 "html_url": "https://github.com/invalid-email-address",
                                 "avatar_url": "https://avatars0.githubusercontent.com/u/148100?v=4"]
        
        let user = User(with: successJSON)
        XCTAssertNil(user)
    }
    
    func testWrongKeysInit() {
        var testUser: User?
        
        // Login Key
        testUser = wrongLoginKey()
        XCTAssertNotNil(testUser)
        XCTAssertTrue(testUser?.userName == nil)
        
        // HTML Key
        testUser = wrongHTMLKey()
        XCTAssertNotNil(testUser)
        XCTAssertTrue(testUser?.userGithubURL == nil)
        
        // Avatar Key
        testUser = wrongAvatarKey()
        XCTAssertNotNil(testUser)
        XCTAssertTrue(testUser?.avatarURL == nil)
    }
}

// MARK: - Helpers

extension UserTest {
    private func wrongLoginKey() -> User? {
        let errorJSON: JSON = ["id": 148100,
                               "wrongLogin": "invalid-email-address",
                               "html_url": "https://github.com/invalid-email-address",
                               "avatar_url": "https://avatars0.githubusercontent.com/u/148100?v=4"]
        
        let user = User(with: errorJSON)
        return user
    }
    
    private func wrongHTMLKey() -> User? {
        let errorJSON: JSON = ["id": 148100,
                               "login": "invalid-email-address",
                               "htmlUrl": "https://github.com/invalid-email-address",
                               "avatar_url": "https://avatars0.githubusercontent.com/u/148100?v=4"]
        
        let user = User(with: errorJSON)
        return user
    }
    
    private func wrongAvatarKey() -> User? {
        let errorJSON: JSON = ["id": 148100,
                               "login": "invalid-email-address",
                               "html_url": "https://github.com/invalid-email-address",
                               "avatarURL": "https://avatars0.githubusercontent.com/u/148100?v=4"]
        
        let user = User(with: errorJSON)
        return user
    }
}







