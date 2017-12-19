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
    
    // MARK: - Variables
    
    private var userJSON: JSON = []
    private var fileJSON: JSON = []
    var json: JSON = []
    
    // MARK: - XCTestCase Cycle
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // Getting a valid User Model JSON
        setUserJSON()
        // Getting a valid File Model JSON
        setFileJSON()
        
        json = ["url": "https://api.github.com/gists/9ae003ae416b7cbda08a1e0b98db331c",
                "forks_url": "https://api.github.com/gists/9ae003ae416b7cbda08a1e0b98db331c/forks",
                "commits_url": "https://api.github.com/gists/9ae003ae416b7cbda08a1e0b98db331c/commits",
                "id": "9ae003ae416b7cbda08a1e0b98db331c",
                "git_pull_url": "https://gist.github.com/9ae003ae416b7cbda08a1e0b98db331c.git",
                "git_push_url": "https://gist.github.com/9ae003ae416b7cbda08a1e0b98db331c.git",
                "html_url": "https://gist.github.com/9ae003ae416b7cbda08a1e0b98db331c",
                "files": fileJSON,
                "public": true,
                "created_at": "2017-12-18T16:20:32Z",
                "updated_at": "2017-12-18T16:20:32Z",
                "description": "Array basic drills links",
                "comments": 0,
                "user": NSNull(),
                "comments_url": "https://api.github.com/gists/9ae003ae416b7cbda08a1e0b98db331c/comments",
                "owner": userJSON,
                "truncated": false]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        userJSON = []
        fileJSON = []
        json = []
    }
    
    // MARK: - Tests
    
    func testSuccessfulInit() {
        let gist = Gist(with: json)
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
    
    func testIdZeroJSONInit() {
        json["id"] = 0
        let user = Gist(with: json)
        XCTAssertNil(user)
    }
    
    func testWrongKeysInit() {
        var testGist: Gist?
        
        // Description Key
        testGist = wrongDescriptionKey()
        XCTAssertNotNil(testGist)
        XCTAssertTrue(testGist?.description == nil)
        setUp()
        
        // APIURL Key
        testGist = wrongAPIURLKey()
        XCTAssertNotNil(testGist)
        XCTAssertTrue(testGist?.apiURL == nil)
        setUp()
        
        // HTMLURL Key
        testGist = wrongHTMLURLKey()
        XCTAssertNotNil(testGist)
        XCTAssertTrue(testGist?.htmlURL == nil)
        setUp()
        
        // File Key
        testGist = wrongFileKey()
        XCTAssertNotNil(testGist)
        XCTAssertTrue(testGist?.files.count == 0)
        setUp()
        
        // Owner Key
        testGist = wrongOwnerKey()
        XCTAssertNotNil(testGist)
        XCTAssertTrue(testGist?.owner == nil)
        setUp()
        
        // is public Key
        testGist = wrongIsPublicKey()
        XCTAssertNotNil(testGist)
        XCTAssertTrue(testGist?.isPublic == nil)
    }
    
    func testWrongValuesInit() {
        var testGist: Gist?
        
        // Description Key
        testGist = wrongDescriptionValue()
        XCTAssertNotNil(testGist)
        XCTAssertTrue(testGist?.description == nil)
        setUp()
        
        // APIURL Key
        testGist = wrongAPIURLValue()
        XCTAssertNotNil(testGist)
        XCTAssertTrue(testGist?.apiURL == nil)
        setUp()
        
        // HTMLURL Key
        testGist = wrongHTMLURLValue()
        XCTAssertNotNil(testGist)
        XCTAssertTrue(testGist?.htmlURL == nil)
        setUp()
        
        // File Key
        testGist = wrongFileValue()
        XCTAssertNotNil(testGist)
        XCTAssertTrue(testGist?.files.count == 0)
        setUp()
        
        // Owner Key
        testGist = wrongOwnerValue()
        XCTAssertNotNil(testGist)
        XCTAssertTrue(testGist?.owner == nil)
        setUp()
        
        // is public Key
        testGist = wrongIsPublicValue()
        XCTAssertNotNil(testGist)
        XCTAssertTrue(testGist?.isPublic == nil)
    }
    
    func testNoFileKeyInJSONInit() {
        json.dictionaryObject?.removeValue(forKey: "files")
        let gist = Gist(with: json)
        XCTAssertNotNil(gist)
        XCTAssertTrue(gist?.files.count == 0)
    }
    
    func testTwoFilesInDictionaryJSONInit() {
        let fileJSONKey = fileJSON.dictionaryValue.keys.first!
        let twoFilesDictionary = [fileJSONKey: fileJSON[fileJSONKey], "test2": fileJSON[fileJSONKey]]
        
        json.dictionaryObject?.removeValue(forKey: "files")
        json["files"].dictionaryObject = twoFilesDictionary
        
        let gist = Gist(with: json)
        XCTAssertNotNil(gist)
        XCTAssertTrue(gist?.files.count == 2)
    }
    
    func testNoOwnerKeyInJSONInit() {
        json.dictionaryObject?.removeValue(forKey: "owner")
        let gist = Gist(with: json)
        XCTAssertNotNil(gist)
        XCTAssertNil(gist?.owner)
    }
}

// MARK: - Helpers

extension GistTest {
    
    // MARK: - Valid JSONs from other user test cases
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
    
    // MARK: - Wrong Keys
    
    private func wrongDescriptionKey() -> Gist? {
        json.dictionaryObject?.removeValue(forKey: "description")
        json["desc"] = "Array basic drills links"
        let gist = Gist(with: json)
        return gist
    }
    
    private func wrongAPIURLKey() -> Gist? {
        json.dictionaryObject?.removeValue(forKey: "url")
        json["URL"] = "https://api.github.com/gists/9ae003ae416b7cbda08a1e0b98db331c"
        let gist = Gist(with: json)
        return gist
    }
    
    private func wrongHTMLURLKey() -> Gist? {
        json.dictionaryObject?.removeValue(forKey: "html_url")
        json["html-url"] = "https://gist.github.com/9ae003ae416b7cbda08a1e0b98db331c"
        let gist = Gist(with: json)
        return gist
    }
    
    private func wrongFileKey() -> Gist? {
        json.dictionaryObject?.removeValue(forKey: "files")
        json["file"] = fileJSON
        let gist = Gist(with: json)
        return gist
    }
    
    private func wrongOwnerKey() -> Gist? {
        json.dictionaryObject?.removeValue(forKey: "owner")
        json["owners"] = userJSON
        let gist = Gist(with: json)
        return gist
    }
    
    private func wrongIsPublicKey() -> Gist? {
        json.dictionaryObject?.removeValue(forKey: "public")
        json["isPublic"] = true
        let gist = Gist(with: json)
        return gist
    }
    
    // MARK: - Wrong Values
    
    private func wrongDescriptionValue() -> Gist? {
        json["description"] = ["description": "Array basic drills links"]
        let gist = Gist(with: json)
        return gist
    }
    
    private func wrongAPIURLValue() -> Gist? {
        json["url"] = 3
        let gist = Gist(with: json)
        return gist
    }
    
    private func wrongHTMLURLValue() -> Gist? {
        json["html_url"] = false
        let gist = Gist(with: json)
        return gist
    }
    
    private func wrongFileValue() -> Gist? {
        json["files"] = JSON.null
        let gist = Gist(with: json)
        return gist
    }
    
    private func wrongOwnerValue() -> Gist? {
        json["owner"] = JSON.null
        let gist = Gist(with: json)
        return gist
    }
    
    private func wrongIsPublicValue() -> Gist? {
        json["public"] = ["isPublic": true,
                          "answer": "yes"]
        let gist = Gist(with: json)
        return gist
    }
}




