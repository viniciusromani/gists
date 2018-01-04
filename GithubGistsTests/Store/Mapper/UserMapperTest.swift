//
//  UserMapperTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 26/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import XCTest

class UserMapperTest: XCTestCase {
    
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
        let userEntity: UserEntity? = UserEntity(id: "34760928",
                                                 userName: "VictoriaDem",
                                                 userGithubURL: URL(string: "https://github.com/VictoriaDem"),
                                                 avatarURL: URL(string: "https://avatars0.githubusercontent.com/u/34760928?v=4"))
        let user = User(mapping: userEntity)
        
        XCTAssertNotNil(user?.id)
        XCTAssert(user?.id == userEntity?.id)
        
        XCTAssertNotNil(user?.userName)
        XCTAssert(user?.userName == userEntity?.userName)
        XCTAssertNotNil(user?.userGithubURL)
        XCTAssert(user?.userGithubURL == userEntity?.userGithubURL)
        XCTAssertNotNil(user?.avatarURL)
        XCTAssert(user?.avatarURL == userEntity?.avatarURL)
    }
    
    /*
     *  The goal is testing the mapper init method for an entity
     *  without all attributes - with some nils in it
     */
    func testInvalidGithubAndAvatarURL() {
        let userEntity: UserEntity?  = UserEntity(id: "34760928",
                                                  userName: "VictoriaDem",
                                                  userGithubURL: nil,
                                                  avatarURL: nil)
        let user = User(mapping: userEntity)
        
        XCTAssertNotNil(user?.id)
        XCTAssert(user?.id == userEntity?.id)
        
        XCTAssertNotNil(user?.userName)
        XCTAssert(user?.userName == userEntity?.userName)
        XCTAssertNil(user?.userGithubURL)
        XCTAssert(user?.userGithubURL == userEntity?.userGithubURL)
        XCTAssertNil(user?.avatarURL)
        XCTAssert(user?.avatarURL == userEntity?.avatarURL)
    }
}
