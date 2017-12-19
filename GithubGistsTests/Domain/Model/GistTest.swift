//
//  GistTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 18/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import XCTest
import SwiftyJSON

class GistTest: XCTestCase {
    
    private var userJSON: JSON?
    private var fileJSON: JSON?
    var successJSON: JSON = []
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        guard name.contains("testSuccessfulInit") else { return }
        
        // Getting a valid User Model JSON
        setUserJSON()
        // Getting a valid File Model JSON
        setFileJSON()
        
        successJSON = ["url": "https://api.github.com/gists/9ae003ae416b7cbda08a1e0b98db331c",
                       "forks_url": "https://api.github.com/gists/9ae003ae416b7cbda08a1e0b98db331c/forks",
                       "commits_url": "https://api.github.com/gists/9ae003ae416b7cbda08a1e0b98db331c/commits",
                       "id": "9ae003ae416b7cbda08a1e0b98db331c",
                       "git_pull_url": "https://gist.github.com/9ae003ae416b7cbda08a1e0b98db331c.git",
                       "git_push_url": "https://gist.github.com/9ae003ae416b7cbda08a1e0b98db331c.git",
                       "html_url": "https://gist.github.com/9ae003ae416b7cbda08a1e0b98db331c",
                       "files": fileJSON!,
                       "public": true,
                       "created_at": "2017-12-18T16:20:32Z",
                       "updated_at": "2017-12-18T16:20:32Z",
                       "description": "Array basic drills links",
                       "comments": 0,
                       "user": NSNull(),
                       "comments_url": "https://api.github.com/gists/9ae003ae416b7cbda08a1e0b98db331c/comments",
                       "owner": userJSON!,
                       "truncated": false]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        guard name.contains("testSuccessfulInit") else { return }
        userJSON = nil
        fileJSON = nil
        successJSON = []
    }
    
    func testSuccessfulInit() {
        let gist = Gist(with: successJSON)
        XCTAssertNotNil(gist)
        XCTAssertNotNil(gist?.id)
    }
    
    func testNilJSONInit() {
        let errorJSON = JSON.null
        let gist = Gist(with: errorJSON)
        XCTAssertNil(gist)
    }
    
    func testEmptyJSONInit() {
        let errorJSON: JSON = []
        let gist = Gist(with: errorJSON)
        XCTAssertNil(gist)
    }
    
    func testEmptyNameJSONInit() {
//        let errorJSON: JSON = ["size": 932,
//                               "raw_url": "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl",
//                               "language": "Erlang"]
//        let finalJSON: JSON = ["": errorJSON]
//        let file = File(with: finalJSON)
//        XCTAssertNil(file)
    }
    
    func testWrongKeysInit() {
//        var testFile: File?
//
//        // Size Key
//        testFile = wrongSizeKey()
//        XCTAssertNotNil(testFile)
//        XCTAssertTrue(testFile?.size == nil)
//
//        // Language Key
//        testFile = wrongLanguageKey()
//        XCTAssertNotNil(testFile)
//        XCTAssertTrue(testFile?.language == nil)
//
//        // URL Key
//        testFile = wrongURLKey()
//        XCTAssertNotNil(testFile)
//        XCTAssertTrue(testFile?.url == nil)
    }
}

// MARK: - Helpers

extension GistTest {
    
    // Getting valid JSONs from other user test cases
    private func setUserJSON() {
        let userTestCase = UserTest()
        userTestCase.setUp()
        userTestCase.testSuccessfulInit()
        userJSON = userTestCase.json
    }
    
    private func setFileJSON() {
        let fileTestCase = FileTest()
        fileTestCase.setUp()
        fileTestCase.testSuccessfulInit()
        fileJSON = fileTestCase.json
    }
}




