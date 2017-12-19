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
    
    // MARK: - Variables
    
    var json: JSON = []
    
    // MARK: - XCTestCase Cycle
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        json = ["id": 148100,
                "login": "invalid-email-address",
                "html_url": "https://github.com/invalid-email-address",
                "avatar_url": "https://avatars0.githubusercontent.com/u/148100?v=4"]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        json = []
    }
    
    // MARK: - Tests
    
    func testSuccessfulInit() {
        let user = User(with: json)
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
        json["id"] = 0
        let user = User(with: json)
        XCTAssertNil(user)
    }
    
    func testWrongKeysInit() {
        var testUser: User?
        
        // Login Key
        testUser = wrongLoginKey()
        XCTAssertNotNil(testUser)
        XCTAssertTrue(testUser?.userName == nil)
        setUp()
        
        // HTML Key
        testUser = wrongHTMLKey()
        XCTAssertNotNil(testUser)
        XCTAssertTrue(testUser?.userGithubURL == nil)
        setUp()
        
        // Avatar Key
        testUser = wrongAvatarKey()
        XCTAssertNotNil(testUser)
        XCTAssertTrue(testUser?.avatarURL == nil)
    }
    
    func testWrongValuesInit() {
        var testUser: User?
        
        // Login Key
        testUser = wrongLoginValue()
        XCTAssertNotNil(testUser)
        XCTAssertTrue(testUser?.userName == nil)
        setUp()
        
        // HTML Key
        testUser = wrongHTMLValue()
        XCTAssertNotNil(testUser)
        XCTAssertTrue(testUser?.userGithubURL == nil)
        setUp()
        
        // Avatar Key
        testUser = wrongAvatarValue()
        XCTAssertNotNil(testUser)
        XCTAssertTrue(testUser?.avatarURL == nil)
    }
}

// MARK: - Helpers

extension UserTest {
    
    // MARK: - Wrong Keys
    
    private func wrongLoginKey() -> User? {
        json.dictionaryObject?.removeValue(forKey: "login")
        json["wrongLogin"] = "invalid-email-address"
        let user = User(with: json)
        return user
    }
    
    private func wrongHTMLKey() -> User? {
        json.dictionaryObject?.removeValue(forKey: "html_url")
        json["htmlUrl"] = "https://github.com/invalid-email-address"
        let user = User(with: json)
        return user
    }
    
    private func wrongAvatarKey() -> User? {
        json.dictionaryObject?.removeValue(forKey: "avatar_url")
        json["avatarURL"] = "https://avatars0.githubusercontent.com/u/148100?v=4"
        let user = User(with: json)
        return user
    }
    
    // MARK: - Wrong Values
    
    private func wrongLoginValue() -> User? {
        json["login"] = 0
        let user = User(with: json)
        return user
    }
    
    private func wrongHTMLValue() -> User? {
        json["html_url"] = true
        let user = User(with: json)
        return user
    }
    
    private func wrongAvatarValue() -> User? {
        json["avatar_url"] = [:]
        let user = User(with: json)
        return user
    }
}

