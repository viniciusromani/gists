//
//  ServiceTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 03/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import XCTest

class ServiceTest: XCTestCase {
    
    var gistWorker: GistWorker!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        gistWorker = GistWorker(store: GistRestStore())
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchPublicGists() {
        let ex = expectation(description: "public gists were fetch")
        gistWorker.fetchPublicGists(successHandler: { (gists) in
            XCTAssert(gists.count >= 0)
            ex.fulfill()
        }) { (error) in
            XCTAssert(true)
        }
        wait(for: [ex], timeout: 30.0)
    }
    
    func testFetchGist() {
        let ex = expectation(description: "public gists were fetch")
        gistWorker.fetchGist(with: "72195ef6fcaf7ae444592e47d0e35e0c", successHandler: { (gist) in
            XCTAssert(gist.id != nil)
            ex.fulfill()
        }) { (error) in
            XCTAssert(true)
        }
        wait(for: [ex], timeout: 30.0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
