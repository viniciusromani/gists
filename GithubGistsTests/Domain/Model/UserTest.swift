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
        let successJSON: JSON = ["id": 2,
                                 "login": "viniciusromani",
                                 "html_url": "",
                                 "avatar_url": ""]
        
        let user = User(with: successJSON)
        XCTAssertNotNil(user)
    }
    
    func 
}
